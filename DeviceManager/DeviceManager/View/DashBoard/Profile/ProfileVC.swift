//
//  ProfileVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC ,UITableViewDelegate, UITableViewDataSource {
    
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
        guard let dashBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: OnBoardingVC.self)) as? OnBoardingVC else { return }
        self.tabBarController?.present(dashBoard, animated: false, completion: nil)
        //        UIApplication.shared.keyWindow?.rootViewController = dashBoard
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
                    guard let CurrentList = UIStoryboard(name: "CurrentDeviceList", bundle: nil).instantiateViewController(withIdentifier: String(describing: CurrentDeviceListVC.self)) as? CurrentDeviceListVC else { return }
                    CurrentList.profilevm = self.profilevm
                    self.navigationController?.pushViewController(CurrentList, animated: true)
                    
                } else { showAlert(message: constants.noCurrentDevices, type: .alert, action :[AlertAction(title:constants.okAction,style: .default ,handler: nil)])
                }
                
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTVCell.self), for: indexPath) as? ProfileTVCell {
            cell.emailLabel?.text = UserDefaults.standard.string(forKey: "email") ?? ""
            return cell
            }
        } else if indexPath.row == 1 {
            if let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: NotificationPreferencesCell.self), for: indexPath) as? NotificationPreferencesCell {
                cell.notificationLabel.text = "frfrf"
                return cell
            }
            return NotificationPreferencesCell()
        } else if indexPath.row == 2 {
            if let cell = profileTableView.dequeueReusableCell( withIdentifier: String( describing: CurrentDevicesCell.self), for: indexPath) as? CurrentDevicesCell {
                cell.currentDeviceList.text = constants.currentPhoneHolders
            }
        }
        return UITableViewCell()
    }
}
