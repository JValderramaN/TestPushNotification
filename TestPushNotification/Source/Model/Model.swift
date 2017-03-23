//
//  Model.swift
//  TestPushNotification
//
//  Created by Momentum Lab 1 on 3/23/17.
//  Copyright © 2017 JoseValderrama. All rights reserved.
//


import Foundation
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper

class Post: Object, Mappable{
    
    dynamic var author:String!
    dynamic var title:String!
    dynamic var subredditName:String!
    dynamic var created:Date!
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        author <- map["data.author"]
        title <- map["data.title"]
        subredditName <- map["data.subreddit"]
        created <- (map["data.created"], DateTransform())
        
    }
}
