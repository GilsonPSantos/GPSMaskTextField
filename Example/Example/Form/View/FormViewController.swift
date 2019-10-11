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
        self.createViewData()
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
        guard self.txtPhone == textField else { return nil }
        if textUpdate.count > 21 {
            return "+ ## (##) ##### - ####"
        }
        return "+ ## (##) #### - ####"
    }
}

//MARK: - AUX METHODS -
extension FormViewController {
    private func setupfields() {
        self.txtName.updateTextWithMask = self.viewData.name
        self.txtEmail.updateTextWithMask = self.viewData.email
        self.txtPassword.updateTextWithMask = self.viewData.password
        self.txtPhone.updateTextWithMask = self.viewData.phone
        self.txtAddress.updateTextWithMask = self.viewData.address
        self.txtPostalCode.updateTextWithMask = self.viewData.postalCode
        self.txtCurrencyValue.updateTextWithMask = self.viewData.currencyValue
        self.validationFields.forceValidation()
    }
    
    private func createViewData() {
        let name = txtName.getTextWithoutMask()
        let email = txtEmail.getTextWithoutMask()
        let password = txtPassword.getTextWithoutMask()
        let phone = txtPhone.getTextWithoutMask()
        let address = txtAddress.getTextWithoutMask()
        let postalCode = txtPostalCode.getTextWithoutMask()
        let currencyValue = txtCurrencyValue.getTextWithoutMask()
        let viewData = FormViewViewData(name: name, email: email, password: password, phone: phone, address: address, postalCode: postalCode, currencyValue: currencyValue)
        print(viewData)
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
