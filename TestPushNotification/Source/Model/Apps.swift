//
//  AppStore.swfit
//  TestPushNotification
//
//  Created by Momentum Lab 1 on 3/23/17.
//  Copyright © 2017 JoseValderrama. All rights reserved.
//


import Foundation
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper

class Apps: Object {
    
    dynamic var id:String = ""
    dynamic var author:String = ""
    dynamic var title:String = ""
    dynamic var iconUrl:String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

extension Apps: Mappable {
    func mapping(map: Map) {
        id <- map["id.label"]
        author <- map["author.name"]
        title <- map["title.label"]
        iconUrl <- map["icon.label"]
    }
}
