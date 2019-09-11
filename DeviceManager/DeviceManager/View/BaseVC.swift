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
    var spinnerVC: SpinnerVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Creates an Activity Indicator
    func startSpinning() {
        spinnerVC = SpinnerVC()
        guard let spinnerVC = spinnerVC else { return }
        
        addChild(spinnerVC)
        spinnerVC.view.frame = view.frame
        view.addSubview(spinnerVC.view)
        spinnerVC.didMove(toParent: self)
    }
    
    func stopSpinning() {
        spinnerVC?.willMove(toParent: nil)
        spinnerVC?.view.removeFromSuperview()
        spinnerVC?.removeFromParent()
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

extension BaseVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
