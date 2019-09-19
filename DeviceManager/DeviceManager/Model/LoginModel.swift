import Foundation
import UIKit



// User Details
struct UserDetails {
    var username: String?
    var passWord: String?
    var email: String?
    var profileImage: String?
    var role: String?
    var ymlID: String?

}
struct CurrentUserDetails {
    var username: String?
    var passWord: String?
    var email: String?
    var profileImage: String?
    var role: String?
    var ymlID: String?
    
}

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
