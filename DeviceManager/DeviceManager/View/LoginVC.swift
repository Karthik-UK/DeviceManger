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

let labelField = LoginVM()
class LoginVC: BaseVC, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {
//    @IBAction func forgotPassword(_ sender: Any) {
//        if let ForgotViewController = UIStoryboard(name: "ForgotPasswordVC", bundle:
    //nil).instantiateViewController(withIdentifier: String(describing: "ForgotPasswordVC")) as? ForgotPasswordVC { return }
//        self.navigationController?.pushViewController(forgotViewController, animated: true)
//    }
    var currentIndex : IndexPath?
    var email: String = ""
    var password: String = ""
    @IBAction func manualLogin(_ sender: Any) {
        print(currentIndex)
        
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        Analytics.logEvent("Login", parameters: ["MODULE": "LoginVC",
                                                 "STATUS": "TRUE"])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        labelField.login()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelField.loginInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoginCell.self), for: indexPath) as? LoginCell {
            currentIndex = indexPath
            cell.selectionStyle = .none
            cell.cellTextField.tag = indexPath.row
            cell.cellLabel.text = labelField.loginInfo[indexPath.row].title
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
        if currentIndex == IndexPath(row: 0, section: 0) {
            if let index = currentIndex {
                if let cell = tableView.cellForRow(at: index) as? LoginCell
                { let text = cell.cellTextField.text
                if text!.isValid(.email) {
                    cell.cellLabel.textColor = .blue
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
}
