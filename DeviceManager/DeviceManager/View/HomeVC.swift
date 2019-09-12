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
    
    let homeVM = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 70
        homeVM.getAllDevices { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
        homeVM.getAllHistory { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.allDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCell.self), for: indexPath) as? HomeCell {
            cell.deviceLabel.adjustsFontSizeToFitWidth = true
            cell.entryTime.adjustsFontSizeToFitWidth = true
            cell.employeeName.adjustsFontSizeToFitWidth = true
            cell.deviceLabel.text = homeVM.allDevices[indexPath.row].deviceId
            cell.employeeName.text = homeVM.allDevices[indexPath.row].employeeName
            if let timeStamp = homeVM.allDevices[indexPath.row].dateCreated {
                cell.entryTime.text = Date.getDate(timeStamp: timeStamp)
            }
            return cell
        }
        return HomeCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentDeviceHistory = homeVM.historicalData.filter {
            $0.deviceInfo?.deviceId == homeVM.allDevices[indexPath.row].deviceId
        }.first
        if let  currentDevice = currentDeviceHistory {
            homeVM.historyData = currentDevice
        }
        
        guard let homeHistoryVC = UIStoryboard(name: "HomeHistory", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeHistoryVC.self)) as? HomeHistoryVC else { return }
        homeHistoryVC.homeVM = self.homeVM
        self.navigationController?.pushViewController(homeHistoryVC, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Current Phone Holders List"
    }
}
