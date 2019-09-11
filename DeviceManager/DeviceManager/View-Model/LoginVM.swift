import Foundation
import UIKit

class LoginVM {
    var loginInfo: [LoginFields] = []
    var email = ""
    var password = ""
    var currentIndex: IndexPath?
    var isEmailValid: Bool = false
    var isPasswordValid: Bool = false

    func login() {
        let details: [LoginFields] = [LoginFields(title: "Email"), LoginFields(title: "Password" )]
        loginInfo = details
    }
    
    func verifyemail(mail: String, password: String? = nil ) {
        FireBaseManager.shared.getusers { [weak self ](mailinfo) in
            for (index, currentmail) in mailinfo.enumerated() {
                if currentmail == mail {
                    self?.email = currentmail
                    //FireBaseManager.shared.addUser(email: mail)
                    let currentindex = index
                    if let password = password {
                        FireBaseManager.shared.getPassWord(emailforpassword: self?.email ?? "", password: password, index: currentindex ) { (message) in
                            if message {
                                self?.email = mail
                                print(self?.email as Any)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Success"), object: nil)
                                
                            } else {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Failure"), object: nil)
                            }
                        }
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Success"), object: nil)
                        return
                    }
                } else {
                    if mailinfo.count - 1 == index {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Failure"), object: nil)
                    }
                }
            }
            if mailinfo.isEmpty {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Failure"), object: nil)
            }
        }
        }
}
