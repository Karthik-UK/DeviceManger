//
//  HomeVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class HomeVC: BaseVC , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var homeVM = HomeVM()
    let constant = KeyConstants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "HomeTableCell")
        getAllDevices()
        getAllHistory()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.allDevices.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableCell.self)) as? HomeTableCell {
            cell.firstLabelTitle.text = constant.deviceName
            cell.secondLabelTitle.text = constant.employeeName
            cell.thirdLabelTitle.text = constant.entryTime
            cell.firstLabel.text = homeVM.allDevices[indexPath.row].deviceId
            cell.secondLabel.text = homeVM.allDevices[indexPath.row].employeeName
            if let timeStamp = homeVM.allDevices[indexPath.row].dateCreated {
                cell.thirdLabel.text = Date.getStringFromTimeStamp(timeStamp: timeStamp)
            }
            return cell
        }
        return HomeTableCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        
        
        
        //
        //        let animation = self.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        //        let animator = animation(animation: animation)
        //        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentDeviceHistory = homeVM.historicalData.filter {
            $0.deviceInfo?.deviceId == homeVM.allDevices[indexPath.row].deviceId
        }.first
        if let  currentDeviceHistory = currentDeviceHistory {
            homeVM.selectedHistoryData = currentDeviceHistory
            guard let homeHistoryVC = UIStoryboard(name: constant.homeHistory, bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeHistoryVC.self)) as? HomeHistoryVC else { return }
            homeHistoryVC.homeVM = self.homeVM
            self.navigationController?.pushViewController(homeHistoryVC, animated: true)
        } else {
            showAlert(message: constant.noDeviceHistoryAvailable, type: .alert, action :[AlertAction(title:constant.okAction,style: .default ,handler: nil)])
    
        }
    }
    
    func getAllDevices() {
        homeVM.getAllDevices { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
    }
    func getAllHistory() {
        homeVM.getAllHistory { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
    }
}
