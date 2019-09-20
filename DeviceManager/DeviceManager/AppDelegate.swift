//
//  AppDelegate.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GoogleSignin.shared.googleCredential()
    
        UNUserNotificationCenter.current().requestAuthorization(options:
            [.badge,.alert,.sound]) { (_,error) in
            if error != nil {
                print("Error Found, \(error?.localizedDescription ?? "")")
                
            } else {
                print("Authorized by the user")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = "Local Notification"
        content.sound = UNNotificationSound.default
        let date = Date(timeIntervalSinceNow: 30)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let uid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            
            print(error?.localizedDescription ?? "")
        }

        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
    }
}
