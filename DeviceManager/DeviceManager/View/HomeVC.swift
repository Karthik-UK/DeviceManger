//
//  HomeVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class HomeVC: BaseVC , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let homevm = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 70
        homevm.getAllDevices { [weak self] isSuccess in
            if isSuccess {
            self?.tableView.reloadData()
            }
        }
        homevm.getAllHistory { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homevm.allDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCell.self), for: indexPath) as? HomeCell {
            cell.deviceLabel.text = homevm.allDevices[indexPath.row].deviceId
            cell.employeeName.text = homevm.allDevices[indexPath.row].employeeName
            //cell.entryTime.text = homevm.allDevices[indexPath.row].dateCreated
            return cell
        }
            return HomeCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentDeviceHistory = homevm.historicalData.filter {
            $0.deviceInfo?.deviceId == homevm.allDevices[indexPath.row].deviceId
        }.first
        if let  currentDevice = currentDeviceHistory {
            homevm.historyData = currentDevice
        }
    
        guard let homeHistoryVC = UIStoryboard(name: "HomeHistory", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeHistoryVC.self)) as? HomeHistoryVC else { return }
        homeHistoryVC.homeVM = self.homevm
        self.navigationController?.pushViewController(homeHistoryVC, animated: false)

    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Current Phone Holders List"
    }
}
