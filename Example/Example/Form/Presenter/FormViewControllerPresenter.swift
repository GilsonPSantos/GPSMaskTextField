//
//  FormViewControllerPresenter.swift
//  Example
//
//  Created by Gilson Santos on 02/10/19.
//  Copyright (c) 2019 GPSMaskTextField. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct FormViewControllerViewData {
    var name = ""
    var email = ""
    var password = ""
    var phone = ""
    var address = ""
    var postalCode = ""
}

//MARK: - VIEW DELEGATE -
protocol FormViewControllerViewDelegate: NSObjectProtocol {
    
}

//MARK: - PRESENTER CLASS -
class FormViewControllerPresenter {
    
    private weak var viewDelegate: FormViewControllerViewDelegate?
    private var viewData = FormViewControllerViewData()
    private let service: FormService
    
    init(viewDelegate: FormViewControllerViewDelegate, service: FormService) {
        self.viewDelegate = viewDelegate
        self.service = service
    }
}

//SERVICE
extension FormViewControllerPresenter {
    public func getForm() {
        
        
        
    }
}

//AUX METHODS
extension FormViewControllerPresenter {
    
}

//DATABASE
extension FormViewControllerPresenter {
    
}
