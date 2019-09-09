//
//  BaseVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

struct  AlertAction {
    var title: String?
    var style: UIAlertAction.Style
    var handler: ((UIAlertAction) -> Void)?
}

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        }
        func showAlert( message: String, title : String, type : UIAlertController.Style, action :[AlertAction]) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: type)
            for item in action {
                alert.addAction(UIAlertAction(title: item.title, style: item.style, handler: item.handler)
                )
            }
            self.present(alert, animated: true, completion: nil)
        
    }
}
