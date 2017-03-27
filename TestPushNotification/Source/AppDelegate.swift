//
//  AppDelegate.swift
//  TestPushNotification
//
//  Created by Momentum Lab 4 on 3/22/17.
//  Copyright © 2017 JoseValderrama. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        registerForPushNotifications()
        
        return true
    }
    
}

// MARK: - Push Notifications

extension AppDelegate{
    func registerForPushNotifications() {
        
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted)
                {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                else{
                }
            })
        }else{ //If user is not on iOS 10 use the old methods we've been using
            let type: UIUserNotificationType = [.badge, .alert, .sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        let token = String(format: "%@", deviceToken as CVarArg)
        print("didRegisterForRemoteNotificationsWithDeviceToken", token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        let message = "didFailToRegisterForRemoteNotificationsWithError: " + error.localizedDescription
        print(message)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification fetchCompletionHandler", userInfo)
        manageAppBagde()
        updateDetail(with: userInfo, completionHandler)
    }
    
    func manageAppBagde(){
        let defaults = UserDefaults.standard
        let newAppBagdeCount = defaults.integer(forKey: kAppBagde) + 1
        defaults.set(newAppBagdeCount, forKey: kAppBagde)
        defaults.synchronize()
        UIApplication.shared.applicationIconBadgeNumber = newAppBagdeCount
    }
    
    func updateDetail(with userInfo: [AnyHashable : Any], _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        if let data = userInfo["data"] as? [AnyHashable : Any], let value = data["value"] as? String{
            if value == kAlamofire{
                NetworkManager.shared.alamofireTest(callback: { (apps) in
                    print("Alamofire Test response in callback:", apps)
                    completionHandler(UIBackgroundFetchResult.newData)
                })
            }else{
                UserDefaults.standard.updateUserDefault(additionalValue: value)
                completionHandler(UIBackgroundFetchResult.newData)
            }
        }else{
            completionHandler(UIBackgroundFetchResult.noData)
        }        
    }
}
