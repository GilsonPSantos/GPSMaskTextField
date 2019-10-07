//
//  FormModel.swift
//  Example
//
//  Created by Gilson Santos on 02/10/19.
//  Copyright © 2019 GPSMaskTextField. All rights reserved.
//

import Foundation

struct FormModel: Codable {
    let name: String
    let email: String
    let password: String
    let phone: String
    let address: String
    let postalCode: String
}
