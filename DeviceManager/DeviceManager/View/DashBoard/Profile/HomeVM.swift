//
//  DashboardVM.swift
//  DeviceManager
//
//  Created by Karthik UK on 10/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

class HomeVM {
    struct DeviceModel {
        var deviceId: String?
        var adminCredential: String?
        var dateCreated: Double?
        var deviceName: String?
        var deviceMacaddress: String?
        var deviceSerialnumber: String?
        var employeeName: String?
        var id: String?
    }
    
    var allDevices = [DeviceModel]()
    
    struct DeviceInfo {
        var deviceName: String?
        var deviceMacaddress: String?
        var id: String?
        var status: String?
        var deviceId: String?
    }
    
    struct FullHistory {
        var assignedTo: String?
        var assignedBy: String?
        var cableCheck: String?
        var createdDate: Double?
        var deviceName: String?
    }
    
    struct HistoricalData {
        var deviceInfo: DeviceInfo?
        var fullHistory: [FullHistory]?
    }
    
    var historicalData = [HistoricalData]()
    
    func getAllHistory(completionHandler: @escaping (Bool) -> Void) {
        FireBaseManager.shared.fetchHistory { [ weak self ](isSuccess, response) in
            self?.historicalData = []
            if isSuccess == true {
                if let response = response {
                    var historyData = HistoricalData()
                    var deviceInfoModel = DeviceInfo()
                    var fullHistory = FullHistory()
                    
                    for eachValue in response {
                        if let deviceInfo = eachValue["device_info"] as? [String: Any] {
                            if let deviceYmlId = deviceInfo["yml_device_id"] as? String {
                                deviceInfoModel.deviceId = deviceYmlId }
                            if let deviceName = deviceInfo["device_name"] as? String {
                                deviceInfoModel.deviceName = deviceName }
                            if let deviceId = deviceInfo["id"] as? String {
                                deviceInfoModel.id = deviceId }
                            if let deviceMacAddress = deviceInfo["device_mac_addr"] as? String {
                                deviceInfoModel.deviceMacaddress = deviceMacAddress }
                            if let deviceStatus = deviceInfo["status"] as? String {
                                deviceInfoModel.status = deviceStatus }
                        }
                        
                        if let history = eachValue["fullHistory"] as? [[String: Any]] {
                            for eachValue in history {
                                if let assignedTo = eachValue["assigned_to"] as? String {
                                    fullHistory.assignedTo = assignedTo }
                                if let assignedBy = eachValue["assignment_by"] as? String {
                                    fullHistory.assignedBy = assignedBy }
                                if let cableCheck = eachValue["cableCheck"] as? String {
                                    fullHistory.cableCheck = cableCheck }
                                if let deviceName = eachValue["device_name"] as? String {
                                    fullHistory.deviceName = deviceName }
                                if let createdDate = eachValue["created_date"] as? String {
                                    let converteddate = Date.toDate(dateString: createdDate)
                                    fullHistory.createdDate = converteddate
                                }
                            }
                        }
                        
                        historyData.deviceInfo = deviceInfoModel
                        historyData.fullHistory = [fullHistory]
                        
                    }
                    self?.historicalData.append(historyData)
                    print(self?.historicalData as Any)
                    completionHandler(true)
                }
            } else {
                completionHandler(false)
            }
            
        }
    }
    
    func getAllDevices(completionHandler: @escaping (Bool) -> Void) {
        FireBaseManager.shared.fetchAllDevices { [ weak self ](isSuccess, response) in
            self?.allDevices = []
            if isSuccess == true {
                var device = DeviceModel()
                if let response = response {
                    for eachDevice in response {
                        if let deviceid = eachDevice["yml_device_id"] as? String { device.deviceId = deviceid }
                        if let admincred = eachDevice["admin_credentials"] as? String { device.adminCredential = admincred }
                        if let datecreated = eachDevice["created_date"] as? String {
                            let converteddate = Date.toDate(dateString: datecreated)
                            device.dateCreated = converteddate
                        }
                        if let devicemacaddr = eachDevice["device_mac_addr"] as? String { device.deviceMacaddress = devicemacaddr }
                        if let devicename = eachDevice["device_name"] as? String { device.deviceName = devicename }
                        if let employeename = eachDevice["name"] as? String { device.employeeName = employeename }
                        if let deviceserialnumber = eachDevice["device_serial_no"] as? String { device.deviceSerialnumber = deviceserialnumber }
                        if let id = eachDevice["id"] as? String { device.id = id }
                        self?.allDevices.append(device)
                    }
                    //print(self?.allDevices as Any)
                    completionHandler(true)
                }
            } else {
                completionHandler(false)
            }
            
        }
    }
}
