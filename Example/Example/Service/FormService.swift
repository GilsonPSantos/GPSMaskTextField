//
//  FormService.swift
//  Example
//
//  Created by Gilson Santos on 02/10/19.
//  Copyright © 2019 GPSMaskTextField. All rights reserved.
//

import Foundation

class FormService {
    
    public func getForm() -> FormModel? {
        var formModel: FormModel?
        guard let file = Bundle.main.path(forResource: "Form", ofType: ".json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: file)) else { return nil }
        do {
            formModel = try JSONDecoder().decode(FormModel.self, from: jsonData)
        } catch let jsonParseError {
            print("Parse error = \(jsonParseError)")
        }
        return formModel
    }
}
