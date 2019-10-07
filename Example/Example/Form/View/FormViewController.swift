//
//  FormViewControllerViewController.swift
//  Example
//
//  Created by Gilson Santos on 02/10/19.
//  Copyright (c) 2019 GPSMaskTextField. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: FormViewControllerPresenter!
    private lazy var viewData:FormViewViewData = FormViewViewData()
    
    // MARK: IBACTIONS
    @IBAction func confirm(_ sender: UIButton) {
        
    }
    
    @IBAction func search(_ sender: UIButton) {
        self.presenter.getForm()
    }
}

//MARK: - LIFE CYCLE -
extension FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FormViewControllerPresenter(viewDelegate: self, service: FormService())
    }
}

//MARK: - DELEGATE PRESENTER -
extension FormViewController: FormViewControllerViewDelegate {
    func setViewData(viewData: FormViewViewData) {
        self.viewData = viewData
        self.setupfields()
    }
}

//MARK: - AUX METHODS -
extension FormViewController {
    private func setupfields() {
        self.txtName.text = self.viewData.name
        self.txtEmail.text = self.viewData.email
        self.txtPassword.text = self.viewData.password
        self.txtPhone.text = self.viewData.phone
        self.txtAddress.text = self.viewData.address
        self.txtPostalCode.text = self.viewData.postalCode
    }
}
