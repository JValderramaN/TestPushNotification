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
    private lazy var backgroundManager: SessionManager = Alamofire.SessionManager.default
    
    var backgroundCompletionHandler: (() -> Void)? {
        get {
            
            return backgroundManager.backgroundCompletionHandler
        }
        set {
            backgroundManager.backgroundCompletionHandler = newValue
        }
    }
    
    init(){
//        if let bundleIdentifier = Bundle.main.bundleIdentifier {
//            backgroundManager = Alamofire.SessionManager(session: URLSession(configuration: URLSessionConfiguration.background(withIdentifier: bundleIdentifier+".background")), delegate: Alamofire.SessionManager.default.delegate)!
//        } else {
            backgroundManager = Alamofire.SessionManager.default
        //}
        self.alamofireTest()
    }
    
     public func alamofireTest(){
        backgroundManager.request(kUrl).responseObject(keyPath:"feed"){ (response: DataResponse<Apps>) in
            let app = response.result.value
            
            let realm = try! Realm()
            let appState = UIApplication.shared.applicationState
            
            if let app = app {
                    try! realm.write {
                        realm.deleteAll()
                        realm.add(app)
                        let defaults = UserDefaults.standard
                        let detailString = "App State: \(appState) \(app.title)"
                        defaults.set(detailString, forKey: kDetail)
                        defaults.synchronize()
                        NotificationCenter.default.post(.init(name: .onDidReceivedPushNotification))
                    }
            }
        }
    }
}
