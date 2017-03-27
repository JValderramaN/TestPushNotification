//
//  UserDefaults+Additions.swift
//  TestPushNotification
//
//  Created by Momentum Lab 1 on 3/27/17.
//  Copyright © 2017 JoseValderrama. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults{
    func updateUserDefault(additionalValue: String){
        let appState = UIApplication.shared.applicationState.rawValue
        
        let detailString = "App State: \(appState) - \(additionalValue)"
//        let defaults = UserDefaults.standard
        self.set(detailString, forKey: kDetail)
        self.synchronize()
        
        NotificationCenter.default.post(.init(name: .onDidReceivedPushNotification))
    }
}
