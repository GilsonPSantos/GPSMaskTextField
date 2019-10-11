//
//  FormViewControllerPresenter.swift
//  Example
//
//  Created by Gilson Santos on 02/10/19.
//  Copyright (c) 2019 GPSMaskTextField. All rights reserved.
//

import Foundation

//MARK: - STRUCT VIEW DATA -
struct FormViewViewData {
    var name = ""
    var email = ""
    var password = ""
    var phone = ""
    var address = ""
    var postalCode = ""
    var currencyValue = ""
}

//MARK: - VIEW DELEGATE -
protocol FormViewControllerViewDelegate: NSObjectProtocol {
    func setViewData(viewData: FormViewViewData)
}

//MARK: - PRESENTER CLASS -
class FormViewControllerPresenter {
    
    weak private var viewDelegate: FormViewControllerViewDelegate?
    private var viewData = FormViewViewData()
    private let service: FormService
    
    init(viewDelegate: FormViewControllerViewDelegate, service: FormService) {
        self.viewDelegate = viewDelegate
        self.service = service
    }
    
    deinit {
        print("XXXX PRESENTER DESALOCADA")
    }

}

//SERVICE
extension FormViewControllerPresenter {
    public func getForm() {
        guard let model = self.service.getForm() else { return }
        self.parseModelForViewData(model)
        self.viewDelegate?.setViewData(viewData: self.viewData)
    }
}

//AUX METHODS
extension FormViewControllerPresenter {
    
    private func parseModelForViewData(_ model: FormModel) {
        self.viewData = FormViewViewData(name: model.name, email: model.email, password: model.password, phone: model.phone, address: model.address, postalCode: model.postalCode, currencyValue: String(model.currencyValue))
    }
    
}

//DATABASE
extension FormViewControllerPresenter {
    
}
