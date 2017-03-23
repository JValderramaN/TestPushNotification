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

protocol NetworkManagerDelegate {
    func responseData(with data:[Post])
}

class NetworkManager {
    
    var postList:[Post] = []
    var delegate:NetworkManagerDelegate?
    
    func fecthData(with delegate:NetworkManagerDelegate){
        self.delegate = delegate
    }
     public func alamofireTest(){
        Alamofire.request(kurl).responseArray(keyPath: "data.children"){ (response: DataResponse<[Post]>) in
            let postArrays = response.result.value
            let realm = try! Realm()
            if let postArrays = postArrays {
                if postArrays.count > 0{
                    try! realm.write {
                        realm.deleteAll()
                        for post in postArrays {
                            self.postList.append(post)
                            realm.add(post)
                        }
                    }
                } else{
                    let post: Results<Post> = { realm.objects(Post.self) }()
                    if post.count > 0 {
                        for  PostItems in post {
                            self.postList.append(PostItems)
                        }
                    }
                }
            }
            self.delegate?.responseData(with: self.postList)
           
        }
    }
}
