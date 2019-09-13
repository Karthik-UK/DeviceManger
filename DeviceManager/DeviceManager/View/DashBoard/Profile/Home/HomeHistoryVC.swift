//
//  HomeHistoryVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit
import Foundation
class HomeHistoryVC: BaseVC ,UITableViewDelegate, UITableViewDataSource {
    
    weak var homeVM: HomeVM?
    let constants = KeyConstants()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ymlDeviceId: UILabel!
    @IBOutlet weak var deviceModel: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        setHeaderView()
        super.viewDidLoad()
        
        historyTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM?.historyData.fullHistory.count ?? 0
    }
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeHistoryCell.self), for: indexPath) as? HomeHistoryCell {
            
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.black.cgColor
            cell.assignedByLabel.adjustsFontSizeToFitWidth = true
            cell.assignedToLabel.adjustsFontSizeToFitWidth = true
            cell.cableLabel.adjustsFontSizeToFitWidth = true
            cell.dateLabel.adjustsFontSizeToFitWidth = true
            cell.assignedByLabel.text = homeVM?.historyData.fullHistory[indexPath.row].assignedBy
            cell.assignedToLabel.text = homeVM?.historyData.fullHistory[indexPath.row].assignedTo
            if homeVM?.historyData.fullHistory[indexPath.row].cableCheck == "1" {
                cell.cableLabel.text = constants.cableGiven
            } else if homeVM?.historyData.fullHistory[indexPath.row].cableCheck == "0" {
                cell.cableLabel.text = constants.cableNotGiven
            }
            if let timeStamp = homeVM?.historyData.fullHistory[indexPath.row].createdDate {
                cell.dateLabel.text = Date.getDate(timeStamp: timeStamp)
            }
            return cell
        }
        return HomeHistoryCell()
    }
   
    func setHeaderView() {
        serialNumber.adjustsFontSizeToFitWidth = true
        ymlDeviceId.adjustsFontSizeToFitWidth = true
        deviceModel.adjustsFontSizeToFitWidth = true
        ymlDeviceId.text = homeVM?.historyData.deviceInfo?.deviceId
        deviceModel.text = homeVM?.historyData.deviceInfo?.deviceName
        serialNumber.text = homeVM?.historyData.deviceInfo?.deviceMacaddress
        
    }
    
}
