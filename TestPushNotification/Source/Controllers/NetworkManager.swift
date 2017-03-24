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

class NetworkManager {
    
    var postList:[Post] = []
    static let shared: NetworkManager = NetworkManager()
    
    init(){
        alamofireTest()
    }
    
    func fecthData() -> [Post]{
        return postList
    }
     public func alamofireTest(){
        Alamofire.request(kurl).responseArray(keyPath: "data.children"){ (response: DataResponse<[Post]>) in
            let postArrays = response.result.value
            let realm = try! Realm()
            if let postArrays = postArrays {
                if postArrays.count > 0 {
                    try! realm.write {
                        realm.deleteAll()
                        for post in postArrays {
                            self.postList.append(post)
                            realm.add(post)
                        }
                    }
                }
            }
        }
    }
}
