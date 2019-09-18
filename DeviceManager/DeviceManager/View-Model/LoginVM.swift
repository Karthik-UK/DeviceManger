import Foundation
import UIKit
import Firebase

class LoginVM {
    var loginInfo: [LoginFields] = []
    var email = ""
    var password = ""
    var constants = KeyConstants()
    var image = ""
    
    func login() {
        let details: [LoginFields] = [LoginFields(title: "Email"), LoginFields(title: "Password" )]
        loginInfo = details
    }
    
    func getProfileDetails(emailId: String , completionHandler: @escaping (Bool ,String) -> Void) {
        let ref = Database.database().reference()
        let user = ref.child("existingUsers")
        user.observeSingleEvent(of: .value) { (snapShot) in
            if let dict = snapShot.value as? [[String: Any]] {
                for item in dict {
                    if let email = item["email"] as? String {
                        if email == emailId {
                            if let userDetails = snapShot.value as? [[String: Any]] {
                                for item in userDetails {
                                    if let imageURL = item["imageUrl"] as? String {
                                        completionHandler(true ,imageURL)
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    //Verify Email for logging In
    func verifyemail(mail :String, password: String? = nil ) {
        FireBaseManager.shared.getusers { [weak self ](mailinfo) in
            for (index,currentmail) in mailinfo.enumerated() {
                if currentmail == mail {
                    
                    FireBaseManager.shared.getName(index: index ,mail: currentmail)
                    UserDefaults.standard.set(currentmail, forKey: "email")
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    FireBaseManager.shared.allOtherUsers = []
                    FireBaseManager.shared.allOtherUsers = mailinfo
                    FireBaseManager.shared.allOtherUsers.removeAll { $0 == UserDefaults.standard.string(forKey: "email") ?? "" }
                    FireBaseManager.shared.addUser(email: mail)
                    let currentindex = index
                    if let password = password {
                        FireBaseManager.shared.getName(index: index ,mail: self?.email ?? "")
                        FireBaseManager.shared.getPassWord(emailforpassword: self?.email ?? "", password: password, index: currentindex ) { (message) in
                            if message {
                                UserDefaults.standard.set(self?.email, forKey: self?.constants.key ?? "")
                                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                FireBaseManager.shared.allOtherUsers = []
                                FireBaseManager.shared.allOtherUsers = mailinfo
                                FireBaseManager.shared.allOtherUsers.removeAll { $0 == UserDefaults.standard.string(forKey: "email") ?? "" }
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Success"), object: nil)
                                
                            } else {
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Failure"), object: nil)
                            }
                        }
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Success"), object: nil)
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
