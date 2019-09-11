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
        homevm.getAllDevices { [weak self]isSuccess in
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
             cell.employeeName.text = homevm.allDevices[indexPath.row].adminCredential
           // cell.entryTime =
            return cell
        }
            return HomeCell()
}
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "rgffrthtrh"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
