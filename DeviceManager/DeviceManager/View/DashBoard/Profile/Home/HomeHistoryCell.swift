//
//  HomeHistoryCell.swift
//  DeviceManager
//
//  Created by Karthik UK on 12/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import Foundation
import UIKit
class HomeHistoryCell: BaseTVC {

    @IBOutlet weak var assignedToLabel: UILabel!
    @IBOutlet weak var assignedByLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cableLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
