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
        var datecreated: String?
        var deviceName: String?
        var devicemacaddress: String?
        var deviceserialnumber: String?
        var employeename: String?
    }
    var allDevices = [DeviceModel]()

    func getAllDevices(completionHandler: @escaping (Bool) -> Void) {
        FireBaseManager.shared.fetchAllDevices { (isSuccess, response) in
            self.allDevices = []
            if isSuccess == true {
            var device = DeviceModel()
            for eachDevice in response ?? [] {
                device.deviceId = eachDevice["yml_device_id"] as? String ?? ""
                self.allDevices.append(device)
            }
            for eachDevice in response ?? [] {
                device.admincredential = eachDevice["yml_device_id"] as? String ?? ""
                self.allDevices.append(device)
                }
                
            completionHandler(true)
            }
            
        }
    }
}
