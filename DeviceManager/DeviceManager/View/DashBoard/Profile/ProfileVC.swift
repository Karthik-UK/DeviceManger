//
//  ProfileVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {
    
    @IBOutlet weak var profileName: UINavigationItem!
    @IBOutlet weak var profileTableView: UITableView!
    
    let loginVM = LoginVM()
    let constants = KeyConstants()
    let pickerConstant = PickerConstants()
    var profilevm = ProfileVM()
    weak var homeVM: HomeVM?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        profileName.title = FireBaseManager.shared.userName
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    @objc func oneTapped(_ sender: Any?) {
        showAlert(message: pickerConstant.selectImage, type: .actionSheet, action: [AlertAction(title: pickerConstant.camera, style: .default, handler: { (_) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker , animated: true, completion: nil)
        }),AlertAction(title: pickerConstant.library, style: .default, handler: { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker , animated: true, completion: nil)
        }),AlertAction(title: pickerConstant.cancel, style: .cancel, handler: nil)])
        
        imagePicker.allowsEditing = false
    }
    
    @IBAction private func logOut(_ sender: Any) {
        showAlert(message: constants.logOut, type: .alert, action :[AlertAction(title: constants.no,style: .cancel ,handler: nil),AlertAction(title: constants.yes, style: .default, handler: { (_) in
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            guard let dashBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: OnBoardingVC.self)) as? OnBoardingVC else { return }
            self.tabBarController?.present(dashBoard, animated: false, completion: nil)
        }
            )])
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let cell = profileTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileTVCell {
            cell.buttonImage.setImage(image, for: .normal)
                let data = image.jpegData(compressionQuality: 1)
                let imageStr = data?.base64EncodedString(options: .lineLength64Characters) ?? ""
                FireBaseManager.shared.updateImage(image: imageStr, emailId: UserDefaults.standard.string(forKey: "email") ?? "")
            
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row {
        case 0:
            cell = getProfileCell(indexPath: indexPath)
        case 1:
            cell = getNotificationCell(indexPath: indexPath)
        case 2:
            cell = getCurrentDeviceCell(indexPath: indexPath)
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            profilevm.currentOwnerDevice = []
            if homeVM?.allDevices.count != nil {
                guard let currentList = UIStoryboard(name: "CurrentDeviceList", bundle: nil).instantiateViewController(withIdentifier: String(describing: CurrentDeviceListVC.self)) as? CurrentDeviceListVC else { return }
                currentList.profileVM = self.profilevm
                currentList.homeVM = self.homeVM
                self.navigationController?.pushViewController(currentList, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    private func getProfileCell(indexPath: IndexPath) -> ProfileTVCell? {
        var cell: ProfileTVCell?
        if let profileCell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTVCell.self), for: indexPath) as? ProfileTVCell {
            profileCell.emailLabel?.text = UserDefaults.standard.string(forKey: constants.key) ?? ""
            loginVM.getProfileDetails(emailId: UserDefaults.standard.string(forKey: "email") ?? "", completionHandler: { (isSuccess, ImageValue) in
                if isSuccess {
                    self.loginVM.image = ImageValue
                    if let decodedData = Data(base64Encoded:self.loginVM.image, options: .ignoreUnknownCharacters) {
                        let userImage = UIImage(data: decodedData)
                        profileCell.buttonImage.setImage(userImage, for: .normal)
                    }
                }
            })
           
            profileCell.buttonImage.addTarget(self, action: #selector(oneTapped(_:)), for: .touchUpInside)
            cell = profileCell
        }
        return cell
    }
    
    private func getNotificationCell(indexPath: IndexPath) -> NotificationPreferencesCell? {
        var cell: NotificationPreferencesCell?
        if let notificationCell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: NotificationPreferencesCell.self), for: indexPath) as? NotificationPreferencesCell {
            notificationCell.notificationLabel.text = "Notification Preferences"
            cell = notificationCell
        }
        return cell
    }
    
    private func getCurrentDeviceCell(indexPath: IndexPath) -> CurrentDevicesCell? {
        var cell: CurrentDevicesCell?
        if let currentDevicesCell = profileTableView.dequeueReusableCell( withIdentifier: String( describing: CurrentDevicesCell.self), for: indexPath) as? CurrentDevicesCell {
            currentDevicesCell.currentDeviceList.text = constants.currentPhoneHolders
            cell = currentDevicesCell
        }
        return cell
    }
}
