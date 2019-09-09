//
//  CurrentDevicesCell.swift
//  DeviceManager
//
//  Created by Karthik UK on 09/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

import UIKit

class CurrentDevicesCell: BaseTVC {
    
    @IBOutlet weak var currentDeviceLabel: UILabel!
    
    @IBOutlet weak var currentDeviceList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
