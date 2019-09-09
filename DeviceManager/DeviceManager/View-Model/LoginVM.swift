import Foundation
import UIKit

class LoginVM {
    var loginInfo: [LoginFields] = []
    var email = ""
    var password = ""
    
    func login() {
        let details: [LoginFields] = [LoginFields(title: "Email"), LoginFields(title: "Password" )]
        loginInfo = details
    }
    
    func verifyemail(mail :String, password: String? = nil) {
        FireBaseManager.shared.getusers { (mailinfo) in
            for currentmail in mailinfo where currentmail == mail {
                FireBaseManager.shared.addUser(email: mail)
                if let password = password {
                    FireBaseManager.shared.getPassWord(emailforpassword: self.email , password:password )
                    
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Success"), object: nil)
                return
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Failure"), object: nil)
        }
    }
    
}
