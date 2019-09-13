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
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        
//        if viewController is ProfileVC {
//            guard let homeVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeVC.self)) as? HomeVC else { return }
//            ProfileVC.homeVM = homeVC.homeVM

        
        }
//        var a:HomeVM
//        if let firstVC = viewController as? HomeVC {
//            var a = firstVC.homeVM        }
//
//        if viewController is ProfileVC {
//            viewController.viewDidLoad()
//        } else if viewController is SecondViewController {
//            print("Second tab")
//        }
        
    
       
    
    func tabBarSetUp() {
        UITabBar.appearance().tintColor = .cyan
        UITabBar.appearance().barTintColor = .black }
}
