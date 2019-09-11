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
                        guard let deviceid = eachDevice["yml_device_id"] as? String else { return }
                        guard let admincred = eachDevice["admin_credentials"] as? String else { return }
                        guard let datecreated = eachDevice["created_date"] as? String else { return }
                        guard let devicemacaddr = eachDevice["device_mac_addr"] as? String else { return }
                        guard let devicename = eachDevice["device_name"] as? String else { return }
                        guard let employeename = eachDevice["name"] as? String else { return }
                        guard let deviceserialnumber = eachDevice["device_serial_no"] as? String else { return }
                        guard let id = eachDevice["id"] as? String else { return }
                        
                        device.deviceId = deviceid
                        device.admincredential = admincred
                        device.datecreated = datecreated
                        device.devicemacaddress = devicemacaddr
                        device.deviceName = devicename
                        device.employeename = employeename
                        device.deviceserialnumber = deviceserialnumber
                        device.id = id
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
