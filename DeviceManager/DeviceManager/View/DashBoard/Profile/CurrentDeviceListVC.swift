//
//  CurrentDeviceList.swift
//  DeviceManager
//
//  Created by Karthik UK on 14/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit
import Foundation
class CurrentDeviceListVC: BaseVC {
    
    @IBOutlet weak var currentDeviceTableView: UITableView!
    
    let constant = KeyConstants()
    weak var homeVM: HomeVM?
    var profileVM = ProfileVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentDeviceTableView.reloadData()
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        self.currentDeviceTableView.register(nib, forCellReuseIdentifier: String(describing: HomeTableCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAllDevices()
    }
    
    func getAllDevices() {
        homeVM?.getAllDevices { [weak self] isSuccess in
            if isSuccess {
                self?.profileVM.getMyDevices(allDevices: self?.homeVM?.allDevices ?? [])
                self?.currentDeviceTableView.reloadData()
            }
        }
    }
}

extension CurrentDeviceListVC:  UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if profileVM.currentOwnerDevice.isEmpty {
            self.currentDeviceTableView.setEmptyMessage(constant.noDevciesFound)
        } else {
            self.currentDeviceTableView.restore()
        }
        
        return profileVM.currentOwnerDevice.count
    }
    
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let transferDeviceVC = UIStoryboard(name: "TransferDevice", bundle: nil).instantiateViewController(withIdentifier: String(describing: TransferDeviceVC.self)) as? TransferDeviceVC else { return }
        
        transferDeviceVC.profileVM = profileVM
        //  let navController = UINavigationController(rootViewController: transferDeviceVC)
        transferDeviceVC.profileVM?.index = indexPath.row
        navigationController?.pushViewController(transferDeviceVC, animated: false)
        //present(navController, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableCell.self)) as? HomeTableCell {
            cell.firstLabelTitle.text = constant.deviceName
            cell.secondLabelTitle.text = constant.deviceId
            cell.thirdLabelTitle.text = constant.entryTime
            cell.firstLabel.text = profileVM.currentOwnerDevice[indexPath.row].deviceName
            cell.secondLabel.text = profileVM.currentOwnerDevice[indexPath.row].deviceId
            if let date = profileVM.currentOwnerDevice[indexPath.row].dateCreated {
                cell.thirdLabel.text = Date.getStringFromTimeStamp(timeStamp: date)
            }
            return cell
        }
        return HomeTableCell()
    }
}
