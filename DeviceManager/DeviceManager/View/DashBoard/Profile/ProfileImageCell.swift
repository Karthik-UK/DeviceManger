//
//  ProfileImageCell.swift
//  DeviceManager
//
//  Created by Karthik UK on 09/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation

import UIKit

class ProfileImageCell: BaseTVC {

//    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var profileDescription: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
