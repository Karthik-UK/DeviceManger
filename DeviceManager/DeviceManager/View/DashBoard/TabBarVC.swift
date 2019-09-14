//
//  DashBoardVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 06/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBarSetUp()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Profile" {
            if let home = tabBarController?.viewControllers?.first as? HomeVC {
                print(home.homeVM.allDevices)
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navVC = viewController as? UINavigationController {
            if let profileVC = navVC.viewControllers.first as? ProfileVC {
                if let navVC2 = tabBarController.viewControllers?.first as? UINavigationController {
                    if let homeVC = navVC2.viewControllers.first as? HomeVC {
                        profileVC.homeVM = homeVC.homeVM
                    }
                }
            }
        }
        
    }
    func tabBarSetUp() {
        UITabBar.appearance().tintColor = .cyan
        UITabBar.appearance().barTintColor = .black
        
    }
 
}
