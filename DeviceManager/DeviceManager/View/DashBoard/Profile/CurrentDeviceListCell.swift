//
//  CurrentDeviceListCell.swift
//  DeviceManager
//
//  Created by Karthik UK on 14/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class CurrentDeviceListCell: BaseTVC {
 
    @IBOutlet weak var deviceName: UILabel!
    
    @IBOutlet weak var deviceId: UILabel!
    @IBOutlet weak var dateAdded: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
