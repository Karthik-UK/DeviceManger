//
//  OnBoardingVM.swift
//  DeviceManager
//
//  Created by Karthik UK on 05/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.

import Foundation
class WalkThroughVM {
    var info: [Descriptions] = []
    func onBoarding() {
        let about:[Descriptions] = [Descriptions(images: "166104", titles: "De.Ma", about: "One stop to manage all your devices"),
            Descriptions(images: "Material Design Mobile HD Wallpaper 591", titles: "De.Ma", about: "One stop to manage all your devices"),
            Descriptions(images: "101723", titles: "De.Ma", about: "One stop to manage all your devices")]
            info = about
    }
}
