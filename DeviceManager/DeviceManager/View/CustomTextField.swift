//
//  CustomTextField.swift
//  DeviceManager
//
//  Created by Karthik UK on 04/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation
import UIKit
class CustomTextField: UITextField {
    var type: KeyType = .defaultcase {
        didSet {
            switch self.type.rawValue {
            case 0:
                super.text = ""
            case 1:
                super.placeholder = self.type.description
                self.keyboardType = .emailAddress
            case 2:
                super.placeholder = self.type.description
                self.keyboardType = .default
                self.isSecureTextEntry = true
            default:
                break
            }
        }
    }
}
