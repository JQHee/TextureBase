//
//  KaneModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/18.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

struct KaneModel {
    var code: Int = 0
    var writeNull: Bool = false
    var info: KaneInfo = KaneInfo(json: JSON.null)
    
    init(json: JSON) {
        code = json["code"].intValue
        writeNull = json["writeNull"].boolValue
        info = KaneInfo(json: json["info"])
    }
}

struct KaneInfo {
    var discuzList = [KaneDiscuzList]()
    
    init(json: JSON) {
        discuzList = json["discuzList"].arrayValue.compactMap({ KaneDiscuzList(json: $0)})
    }
}

struct KaneType {
    var id: Int = 0
    var weight: Int = 0
    var category: Int = 0
    var typeName: String = ""
    
    init(json: JSON) {
        id = json["id"].intValue
        weight = json["weight"].intValue
        category = json["category"].intValue
        typeName = json["typeName"].stringValue
    }
}

struct KaneDetailList {
    var specialRedirect: Int = 0
    var threads: Int = 0
    var bannerUrl: String = ""
    var recommendList: Int = 0
    var todayPosts: Int = 0
    var top: Int = 0
    var posts: Int = 0
    var modelDesc: String = ""
    var iconUrl: String = ""
    var modelName: String = ""
    var weight: Int = 0
    var fid: Int = 0
    var discuzModelTypeId: Int = 0
    
    init(json: JSON) {
        specialRedirect = json["specialRedirect"].intValue
        threads = json["threads"].intValue
        bannerUrl = json["bannerUrl"].stringValue
        recommendList = json["recommendList"].intValue
        todayPosts = json["todayPosts"].intValue
        top = json["top"].intValue
        posts = json["posts"].intValue
        modelDesc = json["modelDesc"].stringValue
        iconUrl = json["iconUrl"].stringValue
        modelName = json["modelName"].stringValue
        weight = json["weight"].intValue
        fid = json["fid"].intValue
        discuzModelTypeId = json["discuzModelTypeId"].intValue
    }
}

struct KaneDiscuzList {
    var detailList = [KaneDetailList]()
    var type: KaneType = KaneType(json: JSON.null)
    
    init(json: JSON) {
        detailList = json["detailList"].arrayValue.compactMap({ KaneDetailList(json: $0)})
        type = KaneType(json: json["type"])
    }
}
