//
//  LoginVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: BaseVC {
    @IBOutlet weak var manualLoginButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    let alertconstant = Alertconstants()
    let loginvm = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginvm.login()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround() 
        tableView.tableFooterView = UIView()
        checkForValidity()
    }
    
    @IBAction private func manualLogin(_ sender: Any) {
        loginvm.verifyemail(mail: loginvm.email,password: loginvm.password)
        NotificationCenter.default.addObserver(self, selector: #selector(navigateDashboard), name: NSNotification.Name(rawValue: "Success"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wrongncredential), name: NSNotification.Name(rawValue: "Failure"), object: nil)
    }
    @IBAction private func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        NotificationCenter.default.addObserver(self, selector: #selector(navigateDashboard), name: NSNotification.Name(rawValue: "Success"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wrongncredential), name: NSNotification.Name(rawValue: "Failure"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func navigateDashboard() {
        Analytics.logEvent("Login", parameters: ["MODULE": "LoginVC",
                                                 "STATUS": "TRUE"])
        guard let dashBoard = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: String(describing: DashBoardVC.self)) as? DashBoardVC else { return }
            dashBoard.email = loginvm.email
        
        self.present(dashBoard, animated: true, completion: nil)
    }
    
    @objc func wrongncredential() {
        Analytics.logEvent("Login", parameters: ["MODULE": "LoginVC",
                                                 "STATUS": "False"])
        showAlert(message: alertconstant.messgae, title: alertconstant.title, type: .alert ,action :[AlertAction(title:alertconstant.alertactionmessage,style: .default ,handler: nil)])
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginButtonBottomConstraint.constant = keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        loginButtonBottomConstraint.constant = 220
    }
}

extension LoginVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginvm.loginInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoginCell.self), for: indexPath) as? LoginCell {
            loginvm.currentIndex = indexPath
            cell.selectionStyle = .none
            cell.cellTextField.tag = indexPath.row
            cell.cellLabel.text = loginvm.loginInfo[indexPath.row].title
            cell.cellTextField.delegate = self
            if indexPath.row == 0 {
                cell.cellTextField.type = .email
            } else {
                loginvm.currentIndex = indexPath
                cell.cellTextField.type = .password
            }
            return cell
        }
        return LoginCell()
    }
}

extension LoginVC:  UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginvm.currentIndex = IndexPath(row: textField.tag, section: 0)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if loginvm.currentIndex == IndexPath(row: 0, section: 0) {
            if let index = loginvm.currentIndex {
                if let cell = tableView.cellForRow(at: index) as? LoginCell {
                    
                    if let text = cell.cellTextField.text {
                        let finalString = text + string
                        loginvm.isEmailValid = finalString.isValid(.email)
                        if loginvm.isEmailValid {
                            cell.cellLabel.textColor = .blue
                            loginvm.email = finalString
                        } else {
                            cell.cellLabel.textColor = .red
                            
                        }
                    }
                }
            }
        }
        if loginvm.currentIndex == IndexPath(row: 1, section: 0) {
            if let index = loginvm.currentIndex {
                if let cell = tableView.cellForRow(at: index) as? LoginCell {
                    if let text = cell.cellTextField.text {
                        let finalString = text + string
                        loginvm.isPasswordValid = finalString.isValid(.password)
                        if loginvm.isPasswordValid {
                            cell.cellLabel.textColor = .blue
                            loginvm.password = finalString
                        } else {
                            cell.cellLabel.textColor = .red
                        }
                    }
                    
                }
            }
        }
        checkForValidity()
        return true
    }
    
    private func checkForValidity() {
        if loginvm.isPasswordValid && loginvm.isEmailValid {
            manualLoginButton.isEnabled = true
            manualLoginButton.backgroundColor = UIColor.green
        } else {
            manualLoginButton.isEnabled = false
            manualLoginButton.backgroundColor = UIColor.gray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
