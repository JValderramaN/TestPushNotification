//
//  NetworkManager.swift
//  TestPushNotification
//
//  Created by Momentum Lab 1 on 3/23/17.
//  Copyright © 2017 JoseValderrama. All rights reserved.
//

import Foundation
import Alamofire
import Realm
import RealmSwift
import UserNotifications

class NetworkManager{
    
    static let shared: NetworkManager = NetworkManager()
    
    public func alamofireTest(callback:@escaping (_ app: Apps?) -> Void){
        Alamofire.request(kUrl).responseObject(keyPath:"feed"){ (response: DataResponse<Apps>) in
            let app = response.result.value
            
            let realm = try! Realm()
            
            if let app = app {
                try! realm.write {
                    realm.deleteAll()
                    realm.add(app)
                    UserDefaults.standard.updateUserDefault(additionalValue: app.title)
                    callback(app)
                }
            } else {
              callback(nil)
            }
        }
    }
}
