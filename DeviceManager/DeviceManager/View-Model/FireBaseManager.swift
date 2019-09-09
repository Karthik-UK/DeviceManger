//
//  FireaBaseManager.swift
//  DeviceManager
//
//  Created by Karthik UK on 06/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.

import UIKit
import Firebase
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
        existing.observeSingleEvent(of: .value) { (DataSnapshot) in
            if let dict = DataSnapshot.value as? [[String: String]] {
                for item in dict {
                    self.mailinfo.append(item["email"]!)
                }
                completion(self.mailinfo)
            }
        }
    }
    func getHomeDetails(){
        ref.child("allDevices")
        
    }
}
