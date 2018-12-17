//
//  AWSelectListModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/17.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AWSelectListModel {
    var message: String = ""
    var code: Int = 0
    var info = [AWSelectListInfo]()
    
    init(json: JSON) {
        message = json["message"].stringValue
        code = json["code"].intValue
        info = json["info"].arrayValue.compactMap({ AWSelectListInfo(json: $0)})
    }
}

struct AWSelectListInfo {
    var description: String = ""
    var topicId: String = ""
    var id: Int = 0
    var ifOrder: Bool = false
    var updateFrequency: Int = 0
    var sourceType: Int = 0
    var platform: Int = 0
    var iconUrl: String = ""
    var newIconBgImg: String = ""
    var weight: Int = 0
    var orderSumNum: Int = 0
    var subTopicJson: String = ""
    var oprator: String = ""
    var topicIconRectangleUrl: String = ""
    var idxpic: String = ""
    var hidden: Int = 0
    var bannerUrl: String = ""
    var updateTime: String = ""
    var topicIconUrl: String = ""
    var topicName: String = ""
    var syncNode: Int = 0
    var followUserCount: Int = 0
    var recommendNum: Int = 0
    var topicIconName: String = ""
    var newIcon: String = ""
    
    init(json: JSON) {
        description = json["description"].stringValue
        topicId = json["topicId"].stringValue
        id = json["id"].intValue
        ifOrder = json["ifOrder"].boolValue
        updateFrequency = json["updateFrequency"].intValue
        sourceType = json["sourceType"].intValue
        platform = json["platform"].intValue
        iconUrl = json["iconUrl"].stringValue
        newIconBgImg = json["newIconBgImg"].stringValue
        weight = json["weight"].intValue
        orderSumNum = json["orderSumNum"].intValue
        subTopicJson = json["subTopicJson"].stringValue
        oprator = json["oprator"].stringValue
        topicIconRectangleUrl = json["topicIconRectangleUrl"].stringValue
        idxpic = json["idxpic"].stringValue
        hidden = json["hidden"].intValue
        bannerUrl = json["bannerUrl"].stringValue
        updateTime = json["updateTime"].stringValue
        topicIconUrl = json["topicIconUrl"].stringValue
        topicName = json["topicName"].stringValue
        syncNode = json["syncNode"].intValue
        followUserCount = json["followUserCount"].intValue
        recommendNum = json["recommendNum"].intValue
        topicIconName = json["topicIconName"].stringValue
        newIcon = json["newIcon"].stringValue
    }
}
