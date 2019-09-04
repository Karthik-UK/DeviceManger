import Foundation

import UIKit
struct LoginFields {
    let title :String
}

enum KeyType: Int {
    case defaultcase = 0
    case email
    case password
    var description: String {
        switch self {
        case .defaultcase:
            return "default"
        case .email:
            return "Enter Mail"
        case .password:
            return "Enter Password"
        
        }
    }
}

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

extension String{
enum Validity{
    case email
    case  password
    
}
enum Regex : String{
    //case age =
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case password = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8}$"
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
    
}
