//
//  FormViewControllerViewController.swift
//  Example
//
//  Created by Gilson Santos on 02/10/19.
//  Copyright (c) 2019 GPSMaskTextField. All rights reserved.
//

import UIKit
import GPSMaskTextField

class FormViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var txtName: GPSMaskTextField!
    @IBOutlet weak var txtEmail: GPSMaskTextField!
    @IBOutlet weak var txtPassword: GPSMaskTextField!
    @IBOutlet weak var txtPhone: GPSMaskTextField!
    @IBOutlet weak var txtAddress: GPSMaskTextField!
    @IBOutlet weak var txtPostalCode: GPSMaskTextField!
    @IBOutlet weak var txtCurrencyValue: GPSMaskTextField!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: FormViewControllerPresenter!
    private lazy var viewData:FormViewViewData = FormViewViewData()
    private var validationFields = ValidationFields()
    // MARK: IBACTIONS
    @IBAction func confirm(_ sender: UIButton) {
        
    }
    
    @IBAction func search(_ sender: UIButton) {
        self.presenter.getForm()
    }
    
    @IBAction func updatePhoneRequired(_ sender: UIButton) {
        self.txtPhone.isRequired = !self.txtPhone.isRequired
    }
    
}

//MARK: - LIFE CYCLE -
extension FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FormViewControllerPresenter(viewDelegate: self, service: FormService())
        self.validationFields.validationAllFields(for: self, delegate: self)
        self.txtPhone.gpsDelegate = self
    }
}

//MARK: - DELEGATE PRESENTER -
extension FormViewController: FormViewControllerViewDelegate {
    func setViewData(viewData: FormViewViewData) {
        self.viewData = viewData
        self.setupfields()
    }
}

//MARK: - DELEGATE GPSVALIDATIONFIELDSDELEGATE -
extension FormViewController: GPSValidationFieldsDelegate {
    func allFieldsValid() {
        self.enableButton(true)
        self.clearBorder()
    }
    
    func notValidAllFields(fildesNotValid: [FieldsValidation]) {
        self.enableButton(false)
        self.clearBorder()
        fildesNotValid.forEach({self.setBorderColor($0.textField)})
    }
}

//MARK: - DELEGATE GPSMASKTEXTFIELDDELEGATE -
extension FormViewController: GPSMaskTextFieldDelegate {
    func updateMask(textField: UITextField, textUpdate: String) -> String? {
        if textUpdate.count > 21 {
            return "+ ## (##) ##### - ####"
        }
        return "+ ## (##) #### - ####"
    }
}

//MARK: - AUX METHODS -
extension FormViewController {
    private func setupfields() {
        self.txtName.updateTextWithValidation = self.viewData.name
        self.txtEmail.updateTextWithValidation = self.viewData.email
        self.txtPassword.updateTextWithValidation = self.viewData.password
        self.txtPhone.updateTextWithValidation = self.viewData.phone
        self.txtAddress.updateTextWithValidation = self.viewData.address
        self.txtPostalCode.updateTextWithValidation = self.viewData.postalCode
        self.txtCurrencyValue.updateTextWithValidation = self.viewData.currencyValue
        self.validationFields.forceValidation()
    }
    
    private func createViewData() {
        
    }
    
    private func enableButton(_ isEnable: Bool) {
        let color = isEnable ? UIColor.enableColor() : UIColor.disableColor()
        self.btnConfirm.isEnabled = isEnable
        self.btnConfirm.backgroundColor = color
    }
    
    private func setBorderColor(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.enableColor().cgColor
    }
    
    private func clearBorder() {
        let mirror = Mirror(reflecting: self)
        for case let (_, value) in mirror.children {
            if value is GPSMaskTextField {
                (value as! GPSMaskTextField).layer.borderWidth = 0
                (value as! GPSMaskTextField).layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}
