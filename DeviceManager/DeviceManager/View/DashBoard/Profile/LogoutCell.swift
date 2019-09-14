//
//  LogoutCell.swift
//  DeviceManager
//
//  Created by Karthik UK on 09/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

import UIKit

class LogoutCell: BaseTVC {

    @IBAction private func logOut(_ sender: Any) {
          UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingVC")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
