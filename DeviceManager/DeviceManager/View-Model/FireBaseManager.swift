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
            if let dict = dataSnapshot.value as? [[String: Any]] {
                completionHandler(true, dict)
            } else {
                completionHandler(false, nil)
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
