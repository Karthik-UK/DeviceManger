//
//  HomeModel.swift
//  DeviceManager
//
//  Created by Karthik UK on 13/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

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
    var cableCheck: Bool?
    var createdDate: Double?
    var deviceName: String?
}

struct HistoricalData {
    var deviceInfo: DeviceInfo?
    var fullHistory: [FullHistory] = []
}
