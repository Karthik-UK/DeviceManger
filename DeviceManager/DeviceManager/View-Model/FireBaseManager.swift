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
    
    func getusers(completion: @escaping (([String]) -> Void)) {
        let existing = ref.child("existingUsers")
        existing.observeSingleEvent(of: .value) { (dataSnapshot) in
            if let dict = dataSnapshot.value as? [[String: String]] {
                for item in dict {
                    self.mailinfo.append(item["email"] ?? "")
                }
                completion(self.mailinfo)
            }
        }
    }
    
    func getName(index: Int ,mail: String) {
        let existing = ref.child("existingUsers").child(String(index))
        existing.observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            for child in snapshot where child.key == "name" {
                if let NameField = child.value as? String {
                    self.userName = NameField
                }
            }
        }
    }
    
    func getPassWord(emailforpassword : String , password : String , index :Int, completionHandler: @escaping (Bool) -> Void) {
        ref.child("existingUsers").child(String(index)).observeSingleEvent(of: .value, with: {  (snapshot) in
            if let pass = snapshot.childSnapshot(forPath: "password").value as? String {
                if password == pass {
                    
                    completionHandler(true)
                } else {
                    completionHandler(false)}
            }
        })
    }
    
    func fetchAllDevices(completionHandler: @escaping (Bool, [[String: Any]]?) -> Void) {
        let deviceNode = self.ref.child("allDevices")
        deviceNode.observeSingleEvent(of: .value) { (dataSnapshot) in
            print(dataSnapshot)
            if let dict = dataSnapshot.value as? [[String: Any]] {
                print(dict)
                completionHandler(true, dict)
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    func updateCurrentUser(deviceId: String ) {
        ref.child("allDevices").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [[String: Any]] {
                for (index,item) in dict.enumerated() {
                    if let ymlDeviceId = item["yml_device_id"] as? String {
                        if deviceId == ymlDeviceId {
                          self.ref.child("allDevices").child(String(index)).updateChildValues(
                                ["name" : FireBaseManager.shared.userName,
                                    "created_date" : Date.currentDate()]
                            )
                        }
                    }
                }
            }
        }
        )
    }
    
    func addHistory(deviceId: String, mail: String) {
        ref.child("historicalData").observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [[String: Any]] {
                for (index,item) in dict.enumerated() {
                    for i in item.keys {
                            print(i)
                        }
                    }
                }
        
            }
        }
        
    
    
    
    func fetchHistory(completionHandler: @escaping (Bool, [[String: Any]]?) -> Void) {
        let historicalData = self.ref.child("historicalData")
        historicalData.observeSingleEvent(of: .value) { (dataSnapshot) in
            if let dict = dataSnapshot.value as? [[String: Any]] {
                print(dict)
                completionHandler(true, dict)
            } else {
                completionHandler(false, nil)
            }
        }
    }
}
