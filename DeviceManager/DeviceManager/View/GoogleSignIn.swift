import UIKit
import Foundation
import Firebase
import GoogleSignIn

typealias CompletionBlock = (_ isSuccess: Bool) -> Void

class GoogleSignin :NSObject ,GIDSignInDelegate {
    
    static let shared  = GoogleSignin()
    
    private override init(){
        super.init()
    }
    
    let firebasedb = FireaBaseDB()
    
    func googleCredential() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        let userId = user.userID
        let idToken = user.authentication.idToken
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        independentfunc(user: user) { (isSuccess) in
            if isSuccess  {
                let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: String(describing: DashBoardVC.self)) as? DashBoardVC
                //UIViewController.present(vc, animated: true, completion: nil)
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Success"), object: nil)
            } else {
                // show error
            }
        }
        
        
    }
    
    public func independentfunc(user: GIDGoogleUser?, completion: @escaping CompletionBlock ) {
        if let email = user?.profile.email {
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) {(authResult, error) in
                if let error = error {
                    print(error)
                }
                else {
                    self.firebasedb.getusers() {
                        print(email)
                        for mail in self.firebasedb.mailinfo {
                            print(mail)
                            if mail == email{
                                print("successs")
                                self.firebasedb.addUser(email: email)
                                completion(true)
                            } else
                            {
                                completion(false)
                                print("Invalid Email")
                            }
                        }
                    }
                    
                }
            }
        }
    }
}
