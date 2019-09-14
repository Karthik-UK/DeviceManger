//
//  CurrentDeviceList.swift
//  DeviceManager
//
//  Created by Karthik UK on 14/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class CurrentDeviceListVC
: BaseVC , UITableViewDataSource , UITableViewDelegate {
    
    weak var homeVM: HomeVM?
    var profilevm = ProfileVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profilevm.currentOwnerDevice.count
        
    }
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrentDeviceListCell.self), for: indexPath as IndexPath) as? CurrentDeviceListCell {
            cell.deviceName.text = profilevm.currentOwnerDevice[indexPath.row].deviceName
            cell.deviceId.text = profilevm.currentOwnerDevice[indexPath.row].deviceId
            if let date = profilevm.currentOwnerDevice[indexPath.row].dateCreated {
                cell.dateAdded.text = Date.getStringFromTimeStamp(timeStamp: date)
            }
            return cell
        }
        return CurrentDeviceListCell()
    }
}
