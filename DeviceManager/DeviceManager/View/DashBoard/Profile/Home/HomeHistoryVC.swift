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

    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM?.historyData.fullHistory.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeHistoryCell.self), for: indexPath) as? HomeHistoryCell {
            cell.assignedByLabel.text = homeVM?.historyData.fullHistory[indexPath.row].assignedBy
            return cell
        }
        return HomeCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()

        return view
    }

}
