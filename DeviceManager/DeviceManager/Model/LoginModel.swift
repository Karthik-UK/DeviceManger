import Foundation
import UIKit

//For label Field
struct LoginFields {
    let title: String
}

//To select type of keyboard
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
