import UIKit
import Foundation
import Firebase
import GoogleSignIn

class GoogleSignin :NSObject ,GIDSignInDelegate {
    
    static let shared = GoogleSignin()
    let loginvm = LoginVM()
    
    private override init() {
        super.init()
    }
    
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
        if let googlemail = user?.profile.email {
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) {( _ , error) in
                if let error = error {
                    print(error)
                } else {
                    self.loginvm.email = googlemail
                    self.loginvm.verifyemail(mail :self.loginvm.email)
                }
            }}
    }
}
