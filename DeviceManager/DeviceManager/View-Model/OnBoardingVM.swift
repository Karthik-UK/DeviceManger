//
//  OnBoardingVM.swift
//  DeviceManager
//
//  Created by Karthik UK on 05/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.

import Foundation
import UIKit
class OnBoardingVM {
    var info: [Descriptions] = []
    func onBoarding() {
        let about: [Descriptions] = [Descriptions(images: UIImage(named:"3455ea17f8301fdbf7927ce662697a1d"), titles: "De.Ma", about:"One stop to manage all your devices"),
            Descriptions(images: UIImage(named: "solid-blue"), titles: "Manage Your Devices", about: "Get notified with all the available free devices"),
            Descriptions(images: UIImage(named: "download"), titles: "Transfer Devices", about: "Request and transfer devices Hassle-free")]
            info = about
    }
}
