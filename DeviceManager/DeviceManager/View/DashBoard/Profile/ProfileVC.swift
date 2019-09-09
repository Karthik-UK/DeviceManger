//
//  ProfileVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView2.dequeueReusableCell(withIdentifier: String(describing: ProfileImageCell.self), for: indexPath) as? ProfileImageCell else { fatalError() }
        cell.profileDescription.text = "dsbvkasbv"
        return cell
        
        
//        if indexPath.row == 0 {
//
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileImageCell.self), for: indexPath) as? ProfileImageCell else { fatalError() }
//            cell.profileDescription.text = "dsbvkasbv"
//            return cell
//
////            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileImageCell.self), for: indexPath) as? ProfileImageCell {
////                cell.profileDescription.text = "description"
////                return cell
////            }
//            return ProfileImageCell()
//        } else if indexPath.row == 1 {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationPreferencesCell.self), for: indexPath) as? NotificationPreferencesCell {
//                //cell.notificationLabel
//                return cell
//            }
//            return NotificationPreferencesCell()
//        } else if indexPath.row == 2 {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrentDevicesCell.self), for: indexPath) as? CurrentDevicesCell {
//               // cell.currentDeviceLabel
//              //  cell.currentDeviceList
//                return cell
//            }
//            return CurrentDevicesCell()
//        } else if indexPath.row == 3 {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LogoutCell.self), for: indexPath) as? LogoutCell {
//               // cell.
//                return cell
//            }
//            return LogoutCell()
//        }
//        return UITableViewCell()
    }
}
