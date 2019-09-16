//
//  Date+Extension.swift
//  DeviceManager
//
//  Created by Karthik UK on 11/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

let defaultDateFormat: String = "yyyy-MM-dd HH:mm:ss"
let requiredDateFormat: String = "hh:mm a MMM dd YYYY"

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
    
    static func currentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = defaultDateFormat
        let result = formatter.string(from: date)
        return result
    }
    
    static func getStringFromTimeStamp (timeStamp: Double , format: String? = requiredDateFormat) -> String? {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let DateString = dateFormatter.string(from: date)
        return DateString
       
    }
}
