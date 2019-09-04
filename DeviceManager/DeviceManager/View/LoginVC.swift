//
//  LoginVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

let labelField = LoginVM()
class LoginVC: BaseVC, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {
    var currentIndex : IndexPath?
    @IBOutlet weak var tableView: UITableView!
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if currentIndex == IndexPath(row: 0, section: 0) {
            if let index = currentIndex {
                let cell = tableView.cellForRow(at: index) as? LoginCell
                let text = cell?.cellTextField.text
                if text!.isValid(.email) {
                    print("validemail")
                } else {
                    print("Invalidmail")}
            }
        }
        if currentIndex == IndexPath(row: 1, section: 0) {
            if let index = currentIndex {
                let cell = tableView.cellForRow(at: index) as? LoginCell
                let text = cell?.cellTextField.text
                if text!.isValid(.password) {
                    print("validposs")
                } else {
                    print("Invalidpss")}
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
}
