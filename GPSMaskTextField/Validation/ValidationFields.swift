//
//  ValidationFields.swift
//  GPSMaskTextFieldProject
//
//  Created by Gilson Santos on 19/02/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - STRUCT -
public struct FieldsValidation {
    var validIsRequired = false
    var name = ""
    var errorValidation: ErrorValidateMask = .none
    var textField = GPSMaskTextField()
}

// MARK: - PROTOCOL USED FOR COMMUNICATION WITH CONTROLLER -
 public protocol ValidationFieldsDelegate: NSObjectProtocol {
    func allFieldsValid()
    func notValidAllFields(fildesNotValid: [FieldsValidation])
//    func notValidForSpecificTextField(field: FieldsValidation)
}

// MARK: - PROTOCOL USED FOR COMMUNICATION WITH CONTROLLER -
@objc public protocol ValidationActionDelegate: NSObjectProtocol {
    @objc optional func showKeyboard(notification: Notification)
    @objc optional func hideKeyboard(notification: Notification)
    
}

// MARK: - START OF THE VALIDATION CLASS -
class ValidationFields {
    
    // - DECLARATION OF VARIABLES -
    private weak var validateDelegate: ValidationFieldsDelegate?
    private weak var actionDelegate: ValidationActionDelegate?
    private var textFieldListForValidation: [FieldsValidation] = [FieldsValidation]()
    private var textFieldListNotValid: [FieldsValidation] = [FieldsValidation]()
    private var finish = false
    private var view: AnyObject!
}

// MARK: - INITIAL SETTING -
extension ValidationFields {
    func validationAllFields(for view: AnyObject, delegate: ValidationFieldsDelegate) {
        self.validateDelegate = delegate
        self.actionDelegate = view as? ValidationActionDelegate
        self.view = view
        self.registerObserver()
        var index = 0
        let object = Mirror(reflecting: view)
        for case let (_, value) in object.children {
            if value is UITextField, value is GPSMaskTextField, (value as! GPSMaskTextField).isRequired {
                let errorValidate:ErrorValidateMask = (value as! GPSMaskTextField).minimumSize != -1 ? .minimumValueIsNotValid : .none
                (value as! GPSMaskTextField).validationDelegate = self
                (value as! GPSMaskTextField).index = index
                let validate = FieldsValidation(validIsRequired: false, name: (value as! GPSMaskTextField).nameTextField, errorValidation: errorValidate, textField: value as! GPSMaskTextField)
                self.textFieldListForValidation.append(validate)
                index += 1
            }
        }
    }
}

// MARK: - IMPLEMENTATION OF VALIDATIONFIELDDELEGATE (GPSTEXTFIELD CLASS COMMUNICATION DELEGATE) -
extension ValidationFields: ValidationFieldDelegate {
    
    // UPDATES REQUIRED FIELD STATUS
    func updateRequired(_ index: Int, isEmptyField: Bool) {
        self.textFieldListForValidation[index].validIsRequired = !isEmptyField
        self.verifyAllValidation(currentElement: self.textFieldListForValidation[index], isEmptyField: isEmptyField)
    }
    
    // UPDATES THE STATUS OF THE ELEMENT IN THE LIST OF FIELDS FOR VALIDATION AND IF IT IS ERROR ACTION THE DELEGATE FOR COMMUNICATION WITH CONTROLLER
    func updateValidationField(_ index: Int, errorValidation: ErrorValidateMask, notificationUser: Bool) {
        self.textFieldListForValidation[index].errorValidation = errorValidation
        if errorValidation != .none, notificationUser {
            self.verifyAllValidation(currentElement: self.textFieldListForValidation[index], isEmptyField: false)
        }
    }
    
    // CHECK IF YOU CAN PASS TO THE NEXT FIELD AFTER YOU ARE VALIDATED
    func nextField(index: Int) {
        if index < self.textFieldListForValidation.count - 1, self.textFieldListForValidation[index + 1].errorValidation != .none {
            self.textFieldListForValidation[index + 1].textField.becomeFirstResponder()
        }
    }
    
    // CHECK IF IT CAN HIDE THE KEYBOARD
    func verifyHideKeyboard(_ index: Int) {
        if self.finish {
            self.textFieldListForValidation[index].textField.endEditing(true)
        }
    }
}

// MARK: - ACTIONS -
extension ValidationFields {
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func showKeyboard(notification: Notification) {
        self.actionDelegate?.showKeyboard?(notification: notification)
    }
    
    @objc private func hideKeyboard(notification: Notification) {
        self.actionDelegate?.hideKeyboard?(notification: notification)
    }
}

// MARK: - AUXILIARY FUNCTIONS -
extension ValidationFields {
    
    // ALWAYS VERIFY THE STATUS OF ALL THE FIELDS AND IF THEY ARE ALL WITH THE REQUIREMENTS ACQUAINTED THE DELEGATE OF COMMUNICATION WITH THE CONTROLLER
    private func verifyAllValidation(currentElement: FieldsValidation, isEmptyField: Bool) {
        var requiredsValids = false
        if currentElement.validIsRequired == isEmptyField {
            requiredsValids = self.verifyRequiredValidation()
        }else {
            requiredsValids = self.notValidRequiredList().count == 0
        }
        let minimumResult = self.verifyMinimumValidation()
        if minimumResult, requiredsValids, !self.finish {
            self.finish = true
            self.validateDelegate?.allFieldsValid()
        }else if !self.finish{
            self.validateDelegate?.notValidAllFields(fildesNotValid: self.textFieldListNotValid)
        }
    }
    
    // CHECK IF IN THE LIST OF FIELDS, ALL REQUIREDS ARE COMPLETED
    private func verifyRequiredValidation() -> Bool {
        self.textFieldListNotValid.removeAll()
        let notRequiredList = self.notValidRequiredList()
        if notRequiredList.count == 0 {
            return true
        }
        self.textFieldListNotValid += notRequiredList
        self.finish = false
        return false
    }
    
    // VERIFY IF IN THE LIST OF FIELDS, ALL THAT HAVE MINIMUM VALUE ARE CORRECT
    private func verifyMinimumValidation() -> Bool {
        self.textFieldListNotValid.removeAll()
        let notMinimumValidList = self.notValidAllMinValueList()
        if notMinimumValidList.count == 0{
            return true
        }
        self.textFieldListNotValid += notMinimumValidList
        self.finish = false
        return false
    }
    
    // RETURNS THE LIST OF FIELDS WITH REQUIRED NOT VALID
    private func notValidRequiredList() -> [FieldsValidation] {
        return self.textFieldListForValidation.filter({!$0.validIsRequired})
    }
    
    // RETURNS THE LIST OF FIELDS OF MINIMUM VALUE NOT VALID
    private func notValidAllMinValueList() -> [FieldsValidation] {
        return self.textFieldListForValidation.filter({$0.errorValidation != .none})
    }
}
