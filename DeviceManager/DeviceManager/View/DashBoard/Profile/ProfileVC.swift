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
    
    let constants = KeyConstants()
    var profilevm = ProfileVM()
    weak var homeVM: HomeVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileName.title = FireBaseManager.shared.userName
    }
    
    @IBAction private func logOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        // show alert and then logout.
        guard let dashBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: OnBoardingVC.self)) as? OnBoardingVC else { return }
        self.tabBarController?.present(dashBoard, animated: false, completion: nil)
        //        UIApplication.shared.keyWindow?.rootViewController = dashBoard
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
            if let allDeviceCount = homeVM?.allDevices.count {
                for i in 0..<allDeviceCount where homeVM?.allDevices[i].employeeName == FireBaseManager.shared.userName {
                    profilevm.totalDevicecount += 1
                    if let allDevices = homeVM?.allDevices[i] {
                        profilevm.currentOwnerDevice.append(allDevices)
                    }
                }
                if profilevm.totalDevicecount != 0 {
                    guard let currentList = UIStoryboard(name: "CurrentDeviceList", bundle: nil).instantiateViewController(withIdentifier: String(describing: CurrentDeviceListVC.self)) as? CurrentDeviceListVC else { return }
                    currentList.profileVM = self.profilevm
                    self.navigationController?.pushViewController(currentList, animated: true)
                    
                } else {
                    showAlert(message: constants.noCurrentDevices, type: .alert, action :[AlertAction(title:constants.okAction,style: .default ,handler: nil)])
                }
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
            cell = profileCell
        }
        return cell
    }
    
    private func getNotificationCell(indexPath: IndexPath) -> NotificationPreferencesCell? {
        var cell: NotificationPreferencesCell?
        if let notificationCell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: NotificationPreferencesCell.self), for: indexPath) as? NotificationPreferencesCell {
            notificationCell.notificationLabel.text = "frfrf"
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
