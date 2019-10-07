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
    private lazy var viewData:FormViewControllerViewData = FormViewControllerViewData()
    
    // MARK: IBACTIONS
    @IBAction func confirm(_ sender: UIButton) {
        
    }
    
    @IBAction func search(_ sender: UIButton) {
        
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

}

//MARK: - AUX METHODS -
extension FormViewController {

}
