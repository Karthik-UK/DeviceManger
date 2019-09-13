//
//  DashBoardVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 06/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarSetUp()
    }
    
    func tabBarSetUp() {
        UITabBar.appearance().tintColor = .cyan
        UITabBar.appearance().barTintColor = .black }
}
