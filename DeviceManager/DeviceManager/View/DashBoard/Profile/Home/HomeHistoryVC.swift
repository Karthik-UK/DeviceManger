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
    
    @IBOutlet private weak var historyTableView: UITableView!
    
    weak var homeVM: HomeVM?
    let constants = KeyConstants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let nib = UINib(nibName: "HistoryHeaderView", bundle: nil)
        self.historyTableView.register(nib, forHeaderFooterViewReuseIdentifier: "HistoryHeaderView")
        
        historyTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM?.selectedHistoryData?.fullHistory.count ?? 0
    }
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeHistoryCell.self), for: indexPath) as? HomeHistoryCell {
            
            cell.assignedByLabel.text = homeVM?.selectedHistoryData?.fullHistory[indexPath.row].assignedBy
            cell.assignedToLabel.text = homeVM?.selectedHistoryData?.fullHistory[indexPath.row].assignedTo
            if let cableCheck = homeVM?.selectedHistoryData?.fullHistory[indexPath.row].cableCheck {

                let cable = cableCheck ? constants.cableGiven : constants.cableNotGiven
                cell.cableLabel.text = cable

            }
            if let timeStamp = homeVM?.selectedHistoryData?.fullHistory[indexPath.row].createdDate {
                cell.dateLabel.text = Date.getStringFromTimeStamp(timeStamp: timeStamp)
            }
            return cell
        }
        return HomeHistoryCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HistoryHeaderView") as? HistoryHeaderView {
            headerView.ymlDeviceId.text = homeVM?.selectedHistoryData?.deviceInfo?.deviceId
            headerView.deviceModel.text = homeVM?.selectedHistoryData?.deviceInfo?.deviceName
            headerView.serialNumber.text = homeVM?.selectedHistoryData?.deviceInfo?.deviceMacaddress
            return headerView
        }
        return HistoryHeaderView()
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
}
