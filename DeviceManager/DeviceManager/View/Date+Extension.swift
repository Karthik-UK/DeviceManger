//
//  Date+Extension.swift
//  DeviceManager
//
//  Created by Karthik UK on 11/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

let defaultDateFormat: String = "yyyy-MM-dd HH:mm:ss"

extension Date {
    static func toDate(dateString: String , format: String? = defaultDateFormat) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let datedata = dateFormatter.date(from: dateString)
        var dateDouble: Double?
        if let timeInterval = datedata?.timeIntervalSince1970 {
            dateDouble = Double(timeInterval)
        }
        return dateDouble
    }
}
