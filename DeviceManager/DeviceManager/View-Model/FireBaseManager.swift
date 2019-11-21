//
//  FireaBaseManager.swift
//  DeviceManager
//
//  Created by Karthik UK on 06/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.

import UIKit
import FirebaseDatabase

class FireBaseManager {
    static let shared = FireBaseManager()
    
    private  init() {
    }
    
    let ref = Database.database().reference()
    var mailinfo: [String] = []
    var userName: String = ""
    var allOtherUsers: [String] = []
    
    func addUser(email: String) {
        ref.child("currentUser").setValue(email)}
   
    func updateImage(image: String ,emailId: String) {
        ref.child("existingUsers").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [[String: Any]] {
                for (index,item) in dict.enumerated() {
                    if let email = item["email"] as? String {
                        if email == emailId {
                            self.ref.child("existingUsers").child(String(index)).updateChildValues(
                                ["imageUrl" : image ]
                            )
                        }
                    }
                }
            }
        }
        )

    }
    
    func getAllExistingUserDetails (completionHandler: @escaping (Bool, [[String: Any]]?) -> Void) {
        let existingNode = self.ref.child("existingUsers")
        DispatchQueue.main.async {
            existingNode.observeSingleEvent(of: .value) { (dataSnapshot) in
            if let dict = dataSnapshot.value as? [[String: Any]] {
                completionHandler(true, dict)
            } else {
                completionHandler(false, nil)
            }
            }
            
        }
    }

    func fetchAllDevices(completionHandler: @escaping (Bool, [[String: Any]]?) -> Void) {
        let deviceNode = self.ref.child("allDevices")
        deviceNode.observeSingleEvent(of: .value) { (dataSnapshot) in
            if let dict = dataSnapshot.value as? [[String: Any]] {
                
                completionHandler(true, dict)
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    func updateCurrentUser(deviceId: String ,mail: String ) {
        ref.child("allDevices").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [[String: Any]] {
                for (index,item) in dict.enumerated() {
                    if let ymlDeviceId = item["yml_device_id"] as? String {
                        if deviceId == ymlDeviceId {
                            self.ref.child("allDevices").child(String(index)).updateChildValues(
                                ["name" : mail,
                                 "created_date" : Date.currentDate()]
                            )
                        }
                    }
                }
            }
        }
        )
    }

    func addHistory(deviceId: String, mail: String, deviceName: String, completionHandler: @escaping (Bool) -> Void) {
        
        ref.child("historicalData").observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [[String: Any]] {
                for (index,item) in dict.enumerated() {
                    if let deviceinfo = item["device_info"] {
                        if let deviceInfo = deviceinfo as? [String:String] {
                            if deviceInfo["yml_device_id"] == deviceId {
                                if let dictValue = dict[index]["fullHistory"] as? [[String: String]] {
                                    let reference = self.ref.child("historicalData").child(String(index)).child("fullHistory").child(String(dictValue.count))
                                    reference.setValue(["assigned_to" : mail ,
                                                   "assignment_by" : FireBaseManager.shared.userName,
                                                   "cableCheck" : "1",
                                                   "created_date" : Date.currentDate(),
                                                   "device_name" : deviceName])
                                    completionHandler(true)
                                }
                            }
                        }
                    }
                    
                }
                completionHandler(false)
            }
        }
    }
    
    func fetchHistory(completionHandler: @escaping (Bool, [[String: Any]]?) -> Void) {
        let historicalData = self.ref.child("historicalData")
        historicalData.observeSingleEvent(of: .value) { (dataSnapshot) in
            if let dict = dataSnapshot.value as? [[String: Any]] {
                completionHandler(true, dict)
            } else {
                completionHandler(false, nil)
            }
        }
    }
}
