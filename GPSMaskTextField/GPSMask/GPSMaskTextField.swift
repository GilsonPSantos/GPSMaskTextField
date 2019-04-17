//
//  GPSMaskTextField.swift
//  GPSMaskTextFieldProject
//
//  Created by Gilson Santos on 19/02/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - PROTOCOL -
public protocol ValidationFieldDelegate {
    func updateRequired(_ index: Int, isEmptyField: Bool)
    func updateValidationField(_ index: Int, errorValidation: ErrorValidateMask, notificationUser: Bool)
    func nextField(index: Int)
    func verifyHideKeyboard(_ index: Int)
}

@IBDesignable public class GPSMaskTextField: UITextField {
    open var index:Int?
    private var maskFormatter = ""
    private var minSize = -1
    private var maxSize = -1
    private var nameField = ""
    private var decimalSeparatorCurrency = ""
    private var mainSeparatorCurrency = ""
    private var type = UIKeyboardType.default
    private var validation = Validation()
    
    var validationDelegate: ValidationFieldDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupDelegate()
        self.getTypeTextField()
        
    }
    
    @IBInspectable open var customMask: String {
        set{
            self.maskFormatter = newValue
            self.minSize = self.maskFormatter.count
            self.maxSize = self.maskFormatter.count
        }get{
            return self.maskFormatter
        }
    }
    
    @IBInspectable open var minimumSize: Int {
        set{
            if !self.maskFormatter.isEmpty {
                self.minSize = self.maskFormatter.count
            }else {
                self.minSize = newValue
            }
        }get{
            return self.minSize
        }
    }
    
    @IBInspectable open var maximumSize: Int {
        set{
            if !self.maskFormatter.isEmpty {
                self.maxSize = self.maskFormatter.count
            }else {
                self.maxSize = newValue
            }
        }get{
            return self.maxSize
        }
    }
    
    @IBInspectable open var nameTextField: String {
        set{
            self.nameField = newValue
        }get{
            return self.nameField
        }
    }
    
    @IBInspectable open var isCurrency: Bool = false
    
    @IBInspectable open var mainSeparator: String {
        set{
            self.mainSeparatorCurrency = newValue
        }get{
            return self.mainSeparatorCurrency
        }
    }
    
    @IBInspectable open var decimalSeparator: String {
        set{
            self.decimalSeparatorCurrency = newValue
        }get{
            return self.decimalSeparatorCurrency
        }
    }
    
    @IBInspectable open var isRequired: Bool = false
    @IBInspectable open var nextToValidate: Bool = true
    
    var textoFinal = ""
}

extension GPSMaskTextField {
    private func setupDelegate(){
        guard let _ = self.delegate else {
            self.delegate = self
            return
        }
    }
    
    private func getTypeTextField(){
        self.type = self.keyboardType
    }
}


extension GPSMaskTextField: UITextFieldDelegate{
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldUpdate: NSString = textField.text as NSString? else {return false}
        var textUpdate = ""
        if range.location <= self.maskFormatter.count - 1, !string.isEmpty, !self.isCurrency {
            let indexText = self.maskFormatter.index(self.maskFormatter.startIndex, offsetBy: range.location)
            let element = !self.maskFormatter.suffix(from: indexText).contains("#") ? "" : string
            textUpdate = textFieldUpdate.replacingCharacters(in: range, with: element)
        }else {
            textUpdate = textFieldUpdate.replacingCharacters(in: range, with: string)
        }
        
        if self.isCurrency, !self.mainSeparator.isEmpty, !self.decimalSeparator.isEmpty {
            let symbolMain = self.mainSeparator.first ?? "."
            let symbolDecimal = self.decimalSeparator.first ?? "'"
            textUpdate = self.validation.formatValueText(text: textUpdate, symbolMain: symbolMain, symbolDecimal: symbolDecimal)
        }else {
            textUpdate = self.insertMask(textField, index: range.location, isRemove: string.isEmpty, textUpdate: textUpdate)
        }
        
        if self.validation.isValidMax(maxValue: self.maxSize, text: textUpdate) {
            textField.text = textUpdate
            if let indexField = self.index{
                self.setValidMinTextField(textUpdate, notificationUser: false)
                self.validationDelegate?.updateRequired(indexField, isEmptyField: textUpdate.isEmpty)
            }
            if textUpdate.count == self.maskFormatter.count, let index = self.index, self.nextToValidate, !textUpdate.isEmpty {
                self.validationDelegate?.nextField(index: index)
            }
        }
        
        
        
        if let index = self.index, self.maxSize != -1 {
            self.validationDelegate?.verifyHideKeyboard(index)
        }
        return false
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.setValidMinTextField(textField.text ?? "", notificationUser: true)
        return true
    }
}

// MARK: - AUXILIARY FUNCTIONS -
extension GPSMaskTextField {
    private func setValidMinTextField(_ text: String, notificationUser: Bool) {
        var typeError = ErrorValidateMask.none
        if !self.validation.isValidMin(minValue: self.minSize, text: text) {
            typeError = .minimumValueIsNotValid
        }else if text.isEmpty, self.isRequired {
            typeError = .RequiredFieldIsEmpty
        }
        if let index = self.index {
            self.validationDelegate?.updateValidationField(index, errorValidation: typeError, notificationUser: notificationUser)
        }
    }
    
    private func insertMask(_ textField: UITextField, index: Int, isRemove: Bool, textUpdate: String) -> String {
        var textUpdateNew = textUpdate
        if !self.maskFormatter.isEmpty, textUpdate.count <= self.maskFormatter.count {
            let indexText = self.maskFormatter.index(self.maskFormatter.startIndex, offsetBy: index)
            let nextIndex = self.maskFormatter.index(self.maskFormatter.startIndex, offsetBy: !isRemove ? index + 1 : isRemove && index != 0 ? index - 1 : index)
            if self.maskFormatter[indexText] != "#", !isRemove {
                textUpdateNew.insert(self.maskFormatter[indexText], at: indexText)
                if index + 1 <= self.maskFormatter.count - 1 {
                    textUpdateNew = self.insertMask(textField, index: index + 1, isRemove: isRemove, textUpdate: textUpdateNew)
                }
            }else if !self.maskFormatter.suffix(from: nextIndex).contains("#"), index + 1 <= self.maskFormatter.count - 1 {
                textUpdateNew = self.insertMask(textField, index: index + 1, isRemove: isRemove, textUpdate: textUpdateNew)
            }
            if isRemove, (self.maskFormatter[indexText] != "#" || self.maskFormatter[nextIndex] != "#") {
                textUpdateNew = self.removeMask(textField, index: index, textUpdate: textUpdateNew)
            }
        }
        return textUpdateNew
    }
    
    private func removeMask(_ textField: UITextField, index: Int, textUpdate: String) -> String {
        if index <= 0 { return "" }
        var textUpdateNew = textUpdate
        let indexText = self.maskFormatter.index(self.maskFormatter.startIndex, offsetBy: textUpdateNew.count - 1)
        if self.maskFormatter[indexText] != "#" {
            textUpdateNew.remove(at: indexText)
            textUpdateNew = self.removeMask(textField, index: index - 1, textUpdate: textUpdateNew)
        }
        return textUpdateNew
    }
    
    private func removeMaskText() -> String {
        let textForReturn = self.text ?? ""
        var returnString = ""
        for (index, text) in self.maskFormatter.enumerated() {
            if text == "#" {
                let indexText = textForReturn.index(textForReturn.startIndex, offsetBy: index)
                returnString += String(textForReturn[indexText])
            }
        }
       return returnString
    }
    
    func getTextWithoutMask() -> String {
        return self.removeMaskText()
    }
}
