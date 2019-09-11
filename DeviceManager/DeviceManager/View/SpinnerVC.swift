//
//  SpinnerVC.swift
//  DeviceManager
//
//  Created by Karthik UK on 11/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class SpinnerVC: BaseVC {
        var spinner: UIActivityIndicatorView?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            spinner = UIActivityIndicatorView(style: .whiteLarge)
            guard let spinner = spinner else { return }
            view = UIView()
            view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.startAnimating()
            spinner.frame = view.frame
            view.addSubview(spinner)
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    
}
