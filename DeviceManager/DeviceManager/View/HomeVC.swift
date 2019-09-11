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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCell.self), for: indexPath) as? HomeCell {
           // cell.deviceLabel =
           // cell.employeeName =
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
