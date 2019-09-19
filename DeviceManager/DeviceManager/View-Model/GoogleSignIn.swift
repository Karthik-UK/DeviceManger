import Firebase
import GoogleSignIn

class GoogleSignin :NSObject ,GIDSignInDelegate {
    
    static let shared = GoogleSignin()
    let loginvm = LoginVM()
    
    private override init() {
        super.init()
    }
    var googleSignInHandler: (( _ error: Error? , _ mail: String) -> Void)?
    var googleSignInCancelHandler : (( _ error: Error?) -> Void )?
    func googleCredential() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                
            } else {
                self.googleSignInCancelHandler?(error)
            }
            return
        }
        if let googlemail = user?.profile.email {
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) {[weak self] ( _ , error) in
                if let error = error {
                     self?.googleSignInHandler?(error , "")
                } else {
                    self?.googleSignInHandler?(nil , googlemail)
                   
                }
            }}
    }
}
