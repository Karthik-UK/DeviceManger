//
//  HomeCell.swift
//  DeviceManager
//
//  Created by Karthik UK on 09/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class HomeCell: BaseTVC {

    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var entryTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
