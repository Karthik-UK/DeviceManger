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
        existing.observeSingleEvent(of: .value) { (dataSnapshot) in
            if let dict = dataSnapshot.value as? [[String: String]] {
                for item in dict {
                    self.mailinfo.append(item["email"]!)
                }
                completion(self.mailinfo)
            }
        }
    }
    func getPassWord(emailforpassword : String , password : String) {
        let existing  = ref.child("existingusers")
        //let existing = ref.child("existingUsers")
//        existing.observeSingleEvent(of: .value) {
//
//
//            }}}
        ref.child("existingUser").child("2").observeSingleEvent(of: .value, with: { (snapshot) in
                let password = snapshot.childSnapshot(forPath: "password").value as? String
                print(password)
            })
    }
    
    
    func getHomeDetails() {
        self.ref.child("allDevices")
        
    }
}
