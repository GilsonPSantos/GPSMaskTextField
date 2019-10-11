//
//  ExtensionUIColor.swift
//  Example
//
//  Created by Gilson Santos on 07/10/19.
//  Copyright © 2019 GPSMaskTextField. All rights reserved.
//

import UIKit

extension UIColor {
    class func disableColor() -> UIColor {
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
    }
    
    class func enableColor() -> UIColor {
        return UIColor(red: 255/255, green: 26/255, blue: 0/255, alpha: 1.0)
    }
}
