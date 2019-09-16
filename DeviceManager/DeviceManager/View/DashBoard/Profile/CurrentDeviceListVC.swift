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
    
    @IBOutlet weak var currentDeviceTableView: UITableView!
    
    let constant = KeyConstants()
    weak var homeVM: HomeVM?
    var profilevm = ProfileVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        self.currentDeviceTableView.register(nib, forCellReuseIdentifier: "HomeCellView")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profilevm.currentOwnerDevice.count
        
    }
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellView") as? HomeCellView {
            cell.firstLabelTitle.text = constant.deviceName
            cell.secondLabelTitle.text = constant.deviceId
            cell.thirdLabelTitle.text = constant.entryTime
            cell.firstLabel.text = profilevm.currentOwnerDevice[indexPath.row].deviceName
            cell.secondLabel.text = profilevm.currentOwnerDevice[indexPath.row].deviceId
            if let date = profilevm.currentOwnerDevice[indexPath.row].dateCreated {
                cell.thirdLabel.text = Date.getStringFromTimeStamp(timeStamp: date)
            }
            return cell
        }
        return CurrentDeviceListCell()
    }
}
