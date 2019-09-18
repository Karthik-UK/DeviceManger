import Foundation
import UIKit

//For label Field
struct LoginFields {
    let title: String
    
}

//To select type of keyboard
enum KeyType: Int {
   
    case email = 0
    case password
    
    var description: String {
        switch self {
        
        case .email:
            return "Enter Mail"
        case .password:
            return "Enter Password"
        }
    }
}
