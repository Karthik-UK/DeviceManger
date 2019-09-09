//
//  LoginVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: BaseVC, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {
    let loginvm = LoginVM()
    let emailverification = EmailVerification()
    var currentIndex : IndexPath?
    @IBOutlet weak var manualLoginButton: UIButton!
    
    @IBAction private func manualLogin(_ sender: Any) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LoginCell {
            if cell.cellLabel.textColor == .blue {
                emailverification.verifyemail(mail: loginvm.email)
                NotificationCenter.default.addObserver(self, selector: #selector(navigateDashboard), name: NSNotification.Name(rawValue: "Success"), object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(wrongncredential), name: NSNotification.Name(rawValue: "Failure"), object: nil)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction private func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        NotificationCenter.default.addObserver(self, selector: #selector(navigateDashboard), name: NSNotification.Name(rawValue: "Success"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wrongncredential), name: NSNotification.Name(rawValue: "Failure"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginvm.login()
        manualLoginButton.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//
//    }
    
    @objc func navigateDashboard() {
        Analytics.logEvent("Login", parameters: ["MODULE": "LoginVC",
                                                       "STATUS": "TRUE"])
        guard let DashBoard = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashBoardVC") as? DashBoardVC else { return }
        self.present(DashBoard, animated: true, completion: nil)
    }
    @objc func wrongncredential() {
        Analytics.logEvent("Login", parameters: ["MODULE": "LoginVC",
                                                       "STATUS": "False"])
        showAlert(message: "Wrong Credentials", title: "Email doesn't Exist ", type: .alert ,action :[AlertAction(title:"OK",style: .default ,handler: nil)])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginvm.loginInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoginCell.self), for: indexPath) as? LoginCell {
            currentIndex = indexPath
            cell.selectionStyle = .none
            cell.cellTextField.tag = indexPath.row
            cell.cellLabel.text = loginvm.loginInfo[indexPath.row].title
            cell.cellTextField.delegate = self

                if indexPath.row == 0 {
                    cell.cellTextField.type = .email
                } else {
                    currentIndex = indexPath
                    cell.cellTextField.type = .password
                }
            return cell
            }
                return LoginCell()
            }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentIndex = IndexPath(row: textField.tag, section: 0)
 
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //use this in button
        if currentIndex == IndexPath(row: 0, section: 0) {
            if let index = currentIndex {
                if let cell = tableView.cellForRow(at: index) as? LoginCell {
                let text = cell.cellTextField.text
                if text!.isValid(.email) {
                    cell.cellLabel.textColor = .blue
                    manualLoginButton.isHidden = false
                    guard let mail = cell.cellTextField.text else { return }
                    loginvm.email = mail

                } else {
                    cell.cellLabel.textColor = .red
                   
                }
                }
            }
        }
        if currentIndex == IndexPath(row: 1, section: 0) {
            if let index = currentIndex {
                let cell = tableView.cellForRow(at: index) as? LoginCell
                let text = cell?.cellTextField.text
                if text!.isValid(.password) {
                    cell?.cellLabel.textColor = .blue
                } else {
                    cell?.cellLabel.textColor = .red
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
