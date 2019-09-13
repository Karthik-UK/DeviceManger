//
//  ProfileVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC ,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var profileTableView: UITableView!
    
    weak var homeVM: HomeVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTVCell.self), for: indexPath) as? ProfileTVCell else { fatalError() }
            cell.emailLabel?.text = UserDefaults.standard.string(forKey: "email") ?? ""
            return cell
        } else if indexPath.row == 1 {
            if let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: NotificationPreferencesCell.self), for: indexPath) as? NotificationPreferencesCell {
                cell.notificationLabel.text = "frfrf"
                return cell
            }
            return NotificationPreferencesCell()
        } else if indexPath.row == 2 {
            if let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: CurrentDevicesCell.self), for: indexPath) as? CurrentDevicesCell {
                if let allDeviceCount = homeVM?.allDevices.count {
                    for i in 0..<allDeviceCount {
                        if homeVM?.allDevices[i].employeeName == "Amba" {
                        cell.currentDeviceLabel.text = homeVM?.allDevices[i].deviceName
                        cell.currentDeviceList.text = homeVM?.allDevices[i].deviceId
                    }
                }
                return cell
            }
            }
            return CurrentDevicesCell()
        
        } 
        return UITableViewCell()
    }

}
