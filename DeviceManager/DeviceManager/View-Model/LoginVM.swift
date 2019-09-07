import Foundation
import UIKit

class LoginVM {
    var loginInfo: [LoginFields] = []
    var email = ""
    func login() {
        let details: [LoginFields] = [LoginFields(title: "Email"), LoginFields(title: "Password" )]
        loginInfo = details
    }
}
