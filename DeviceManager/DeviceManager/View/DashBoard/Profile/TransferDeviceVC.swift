//
//  TransferDeviceVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 16/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class TransferDeviceVC: BaseVC ,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var deviceModelNameLabel: UILabel!
    @IBOutlet weak var transferTextField: UITextField!
    
    weak var profileVM: ProfileVM?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpPicker()
        FireBaseManager.shared.addHistory(deviceId: "frg" ,mail: "tgrtf" )
        
        if let index = profileVM?.index {
            deviceModelNameLabel.text = profileVM?.currentOwnerDevice[index].deviceName
        }
    }
    @IBAction private func TransferDevice(_ sender: Any) {
        
        if let index = profileVM?.index {
            FireBaseManager.shared.updateCurrentUser(deviceId: profileVM?.currentOwnerDevice[index].deviceId ?? "")
        }
        
//        if let text = transferTextField.text
//        {
//            
//        }
        
    }
    
    //    @IBAction func cancelButton(_ sender: Any) {
    //        guard let CurrentDevices = UIStoryboard(name: "CurrentDeviceList", bundle: nil).instantiateViewController(withIdentifier: String(describing: CurrentDeviceListVC.self)) as? CurrentDeviceListVC else { return }
    //        present(CurrentDevices, animated: false)
    //
    //    }
    
    @IBAction private func transferDevice(_ sender: Any) {
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        transferTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FireBaseManager.shared.allOtherUsers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FireBaseManager.shared.allOtherUsers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        transferTextField.text = FireBaseManager.shared.allOtherUsers[row]
    }
    func setUpPicker() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        transferTextField.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.black
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(TransferDeviceVC.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Pick one Email"
        label.textAlignment = .center
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([flexSpace,textBtn,flexSpace,doneButton], animated: true)
        transferTextField.inputAccessoryView = toolBar
    }
}
