//
//  InfomationListModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation

struct InfomationListModel {
    var writeNull: Bool = false
    var info = [InfomationListInfo]()
    var code: Int = 0
    
    init(json: JSON) {
        writeNull = json["writeNull"].boolValue
        info = json["info"].arrayValue.compactMap({ InfomationListInfo(json: $0)})
        code = json["code"].intValue
    }
}

struct InfomationListInfo {
    var nickname: String = ""
    var source: String = ""
    var photosetImgNum: Int = 0
    var showType: Int = 0
    var topicName: String = ""
    var userId: Int = 0
    var penName: String = ""
    var newTopicId: Int = 0
    var digest: String = ""
    var url: String = ""
    var userOrder: Bool = false
    var ptime: String = ""
    var imgsrc = [String]()
    var articleTags: String = ""
    var title: String = ""
    var gameName: String = ""
    var specialId: String = ""
    var largeLogoUrl: String = ""
    var photosetId: String = ""
    var docid: String = ""
    var replyCount: Int = 0
    var topicId: String = ""
    var lmodify: String = ""
    var subtitle: String = ""
    var readSeconds: Int = 0
    var priority: Int = 0
    var fromTopicSource: Bool = false
    var id: Int = 0
    var role: String = ""
    
    init(json: JSON) {
        nickname = json["nickname"].stringValue
        source = json["source"].stringValue
        photosetImgNum = json["photosetImgNum"].intValue
        showType = json["showType"].intValue
        topicName = json["topicName"].stringValue
        userId = json["userId"].intValue
        penName = json["penName"].stringValue
        newTopicId = json["newTopicId"].intValue
        digest = json["digest"].stringValue
        url = json["url"].stringValue
        userOrder = json["userOrder"].boolValue
        ptime = json["ptime"].stringValue
        imgsrc = json["imgsrc"].arrayValue.compactMap({$0.stringValue})
        articleTags = json["articleTags"].stringValue
        title = json["title"].stringValue
        gameName = json["gameName"].stringValue
        specialId = json["specialId"].stringValue
        largeLogoUrl = json["largeLogoUrl"].stringValue
        photosetId = json["photosetId"].stringValue
        docid = json["docid"].stringValue
        replyCount = json["replyCount"].intValue
        topicId = json["topicId"].stringValue
        lmodify = json["lmodify"].stringValue
        subtitle = json["subtitle"].stringValue
        readSeconds = json["readSeconds"].intValue
        priority = json["priority"].intValue
        fromTopicSource = json["fromTopicSource"].boolValue
        id = json["id"].intValue
        role = json["role"].stringValue
    }
}
