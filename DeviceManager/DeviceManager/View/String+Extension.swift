//
//  Extension+String.swift
//  DeviceManager
//
//  Created by Karthik UK on 04/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation
extension String {
    enum Validity {
        case email
        case  password
    }
    
    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,64}"
        case password = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    }
    func isValid(_ validityType: Validity) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = " "
        switch validityType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

