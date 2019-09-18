//
//  ProfileVM.swift
//  DeviceManager
//
//  Created by Karthik UK on 11/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

class ProfileVM {
    var currentOwnerDevice = [DeviceModel]()
    var email: String = ""
    var totalDevicecount: Int = 0
    var index: Int = 0
    
    func getMyDevices(allDevices: [DeviceModel]) {
        currentOwnerDevice = []
        for i in 0..<allDevices.count where allDevices[i].employeeName == FireBaseManager.shared.userName {
            totalDevicecount += 1
            currentOwnerDevice.append(allDevices[i])
        }
    }
}
