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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTVCell.self), for: indexPath) as? ProfileTVCell else { fatalError() }
            cell.emailLabel?.text = UserDefaults.standard.string(forKey: "email") ?? "boom"
            return cell
        } else if indexPath.row == 1 {
            if let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: NotificationPreferencesCell.self), for: indexPath) as? NotificationPreferencesCell {
                cell.notificationLabel.text = "frfrf"
                return cell
            }
            return NotificationPreferencesCell()
        } else if indexPath.row == 2 {
            if let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: CurrentDevicesCell.self), for: indexPath) as? CurrentDevicesCell {
                // cell.currentDeviceLabel
                //  cell.currentDeviceList
                return cell
            }
            return CurrentDevicesCell()
        } else if indexPath.row == 3 {
            if let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: LogoutCell.self), for: indexPath) as? LogoutCell {
                // cell.
                return cell
            }
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
