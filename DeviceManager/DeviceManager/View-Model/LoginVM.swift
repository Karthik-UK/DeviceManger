import Foundation
import UIKit
import Firebase

class LoginVM {
    var loginInfo: [LoginFields] = []
    var constants = KeyConstants()
    var allUserDetails = [UserDetails]()
    var currentUserDetails = UserDetails()
    var email: String = ""
    var password: String = ""
    
    func login() {
        let details: [LoginFields] = [LoginFields(title: "Email"), LoginFields(title: "Password" )]
        loginInfo = details
    }
    
    func getCurrentUserDetails(emailID: String ,completionHandler: @escaping (Bool) -> Void) {
        FireBaseManager.shared.getAllExistingUserDetails { [ weak self ](isSuccess, response) in
            if isSuccess == true {
                if let response = response {
                    for eachUser in response {
                        if let email = eachUser["email"] as? String {
                            if email == emailID {
                                if let email = eachUser["email"] as? String {
                                    self?.currentUserDetails.email = email }
                                if let ymlID = eachUser["YML-ID"] as? String {
                                    self?.currentUserDetails.ymlID = ymlID }
                                if let image = eachUser["imageUrl"] as? String {
                                    self?.currentUserDetails.profileImage = image
                                }
                                if let userName = eachUser["name"] as? String {
                                    self?.currentUserDetails.username = userName }
                                if let passWord = eachUser["password"] as? String {
                                    self?.currentUserDetails.passWord = passWord }
                                if let role = eachUser["role"] as? String {
                                    self?.currentUserDetails.role = role }
                            }
                        }
                        
                    }
                    completionHandler(true)
                }
            } else {
                completionHandler(false)
            }
            
        }
    }
    
    func getAllUserDetails(completionHandler: @escaping (Bool) -> Void) {
        FireBaseManager.shared.getAllExistingUserDetails { [ weak self ](isSuccess, response) in
            self?.allUserDetails = []
            if isSuccess == true {
                var userDetails = UserDetails()
                if let response = response {
                    for eachUser in response {
                        if let email = eachUser["email"] as? String {
                            userDetails.email = email }
                        if let ymlID = eachUser["YML-ID"] as? String {
                            userDetails.ymlID = ymlID }
                        if let image = eachUser["imageUrl"] as? String {
                            userDetails.profileImage = image
                        }
                        if let userName = eachUser["name"] as? String {
                            userDetails.username = userName }
                        if let passWord = eachUser["password"] as? String {
                            userDetails.passWord = passWord }
                        if let role = eachUser["role"] as? String {
                            userDetails.role = role }
                        
                        self?.allUserDetails.append(userDetails)
                    }
                    completionHandler(true)
                }
            } else {
                completionHandler(false)
            }
            
        }
    }
    
    func verifyEmail(mail :String, password: String? = nil, type: String, completionHandler: @escaping (String ,Bool) -> Void) {
        
        for user in allUserDetails {
            if let userEmail = user.email {
                if userEmail == mail {
                    UserDefaults.standard.set(mail, forKey: "email")
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    if let password = password {
                        if let userPassword = user.passWord {
                            if  userPassword == password {
                                UserDefaults.standard.set(mail, forKey: "email")
                                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                completionHandler("Login", true)
                                return
                            } else {
                                completionHandler("Login", false)}
                            
                        }
                    } else { completionHandler("GoogleLogin",true)
                        return
                        
                    }
                    
                }
            }
        }
        if type == "Login" {
            completionHandler("Login" , false) }
        if type == "GoogleLogin" {
            completionHandler("GoogleLogin" , false)}
        
    }
}
