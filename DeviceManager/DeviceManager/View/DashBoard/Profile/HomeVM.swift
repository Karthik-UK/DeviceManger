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
        var admincredential: String?
        var datecreated: Date?
        var deviceName: String?
        var devicemacaddress: String?
        var deviceserialnumber: String?
        var employeename: String?
        var id: String?
    }
    
    var allDevices = [DeviceModel]()
    
    func getAllDevices(completionHandler: @escaping (Bool) -> Void) {
        FireBaseManager.shared.fetchAllDevices { [ weak self ](isSuccess, response) in
            self?.allDevices = []
            if isSuccess == true {
                var device = DeviceModel()
                if let response = response {
                    for eachDevice in response {
                        if let deviceid = eachDevice["yml_device_id"] as? String { device.deviceId = deviceid }
                        if let admincred = eachDevice["admin_credentials"] as? String { device.admincredential = admincred }
                        if let datecreated = eachDevice["created_date"] as? String {
                            let converteddate = datecreated.toDate()
                            device.datecreated = converteddate
                            }
                        if let devicemacaddr = eachDevice["device_mac_addr"] as? String { device.devicemacaddress = devicemacaddr }
                        if let devicename = eachDevice["device_name"] as? String { device.deviceName = devicename }
                        if let employeename = eachDevice["name"] as? String { device.employeename = employeename }
                        if let deviceserialnumber = eachDevice["device_serial_no"] as? String { device.deviceserialnumber = deviceserialnumber }
                        if let id = eachDevice["id"] as? String { device.id = id }
                        self?.allDevices.append(device)
                    }
                    print(self?.allDevices as Any)
                    completionHandler(true)
                }
            } else {
                completionHandler(false)
            }
            
        }
    }
}
