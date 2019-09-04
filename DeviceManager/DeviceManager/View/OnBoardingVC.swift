//
//  ViewController.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class ViewController: BaseVC {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var getStarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getStarted.layer.borderWidth = 2
        getStarted.layer.borderColor = UIColor.black.cgColor
        
    }
}
