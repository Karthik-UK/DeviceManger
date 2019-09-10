//
//  DashBoardVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 06/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class DashBoardVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .cyan
        UITabBar.appearance().barTintColor = .black
    }
//        guard let viewControllers = viewControllers else{
//            return
//        }
//        for viewcontroller in viewControllers
//        {
//            if let profilenavigator = viewcontroller as? ProfileVC{
//              //  profilenavigator.
//            }
//            
//        }
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
