//
//  FireaBaseDB.swift
//  DeviceManager
//
//  Created by Karthik UK on 06/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FireaBaseDB: BaseVC {
    
    let ref = Database.database().reference()
    var mailinfo: [String] = []
    
        func addUser(email: String) {
            ref.child("currentUser").setValue(email)}
    
    func getusers(completion: @escaping (() -> Void)) {
            let existing = ref.child("existingUsers")
            existing.observeSingleEvent(of: .value) { (DataSnapshot) in
                //print(DataSnapshot.value)
                if let dict = DataSnapshot.value as? [[String: String]] {
                    for item in dict {
                        self.mailinfo.append(item["email"]!)
                        print(self.mailinfo)
                    }
                    completion()
                }
              }
            }
        }
