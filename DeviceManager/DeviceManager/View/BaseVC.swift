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
    func showAlerts( message: String, title : String, arrofBtns: [BtnAction], type : UIAlertController.Style, phonenumber : String? = nil, Action :ActionType? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: type)
        for button in arrofBtns {
            let customAction = CustomAction(title: button.title, style: UIAlertAction.Style.default, handler: { [weak self] (action) in
                guard let weakSelf = self else { return }
                if let custom = action as? CustomAction {
                    weakSelf.doAction(type: custom.btnType)
                }
            })
            customAction.btnType = button.actionType
            alert.addAction(customAction)

        }
        self.present(alert, animated: true, completion: nil)
    }
    struct  BtnAction {
        let title: String?
        let actionType : ActionType
    }
    enum ActionType: Int {
        case phone
        case email
        case noAction
    }
    func doAction(type: ActionType?) {
        debugPrint("Action \(type)")
        switch type! {
        case .phone:
            guard let number = URL(string: "tel://" + "34748734873487" ) else { return }
            if UIApplication.shared.canOpenURL(number) == true{
                UIApplication.shared.open(number)
            }
        case .email:
            debugPrint("Email")
        case .noAction:
            debugPrint("No Action")
        }
    }
    class CustomAction : UIAlertAction {
        var btnType: ActionType?
        override init() {
            super.init()
        }
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
    //Stops Indicator
    func stopSpinning() {
        spinnerVC?.willMove(toParent: nil)
        spinnerVC?.view.removeFromSuperview()
        spinnerVC?.removeFromParent()
    }
    //Alert Function
    func showAlert( message: String, title: String? = nil, type: UIAlertController.Style, action: [AlertAction]) {
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
