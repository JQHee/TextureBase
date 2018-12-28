//
//  InfomationDetailModel.swift
//  
//
//  Created by midland on 2018/12/20.
//

import UIKit
import SwiftyJSON

struct InfomationDetailModel {
    var code: Int = 0
    var message: String = ""
    var info: InfomationDetailInfo = InfomationDetailInfo(json: JSON.null)
    
    init(json: JSON) {
        code = json["code"].intValue
        message = json["message"].stringValue
        info = InfomationDetailInfo(json: json["info"])
    }
}

struct InfomationDetailInfo {
    var isCollectArticle: Bool = false
    var tie: InfomationDetailTie = InfomationDetailTie(json: JSON.null)
    var article: InfomationDetailArticle = InfomationDetailArticle(json: JSON.null)
    var topicOrderSource: InfomationDetailTopicOrderSource = InfomationDetailTopicOrderSource(json: JSON.null)
    
    init(json: JSON) {
        isCollectArticle = json["isCollectArticle"].boolValue
        tie = InfomationDetailTie(json: json["tie"])
        article = InfomationDetailArticle(json: json["article"])
        topicOrderSource = InfomationDetailTopicOrderSource(json: json["topicOrderSource"])
    }
}

struct InfomationDetailTopicOrderSource {
    var collect: Bool = false
    
    init(json: JSON) {
        collect = json["collect"].boolValue
    }
}

struct InfomationDetailArticle {
    var replyBoard: String = ""
    var groupId: Int = 0
    var replyCount: Int = 0
    var tid: String = ""
    var hidePlane: Bool = false
    var ptime: String = ""
    var template: String = ""
    var source: String = ""
    var penName: String = ""
    var picnews: Bool = false
    var img = [InfomationDetailImg]()
    var shareLink: String = ""
    var category: String = ""
    var advertiseType: String = ""
    var digest: String = ""
    var docid: String = ""
    var articleType: String = ""
    var searchKw = [InfomationDetailSearchKw]()
    var hasNext: Bool = false
    var voicecomment: String = ""
    var threadVote: Int = 0
    var title: String = ""
    var topiclist = [InfomationDetailTopiclist]()
    var ec: String = ""
    var dkeys: String = ""
    var threadAgainst: Int = 0
    var body: String = ""
    
    init(json: JSON) {
        replyBoard = json["replyBoard"].stringValue
        groupId = json["groupId"].intValue
        replyCount = json["replyCount"].intValue
        tid = json["tid"].stringValue
        hidePlane = json["hidePlane"].boolValue
        ptime = json["ptime"].stringValue
        template = json["template"].stringValue
        source = json["source"].stringValue
        penName = json["penName"].stringValue
        picnews = json["picnews"].boolValue
        img = json["img"].arrayValue.compactMap({ InfomationDetailImg(json: $0)})
        shareLink = json["shareLink"].stringValue
        category = json["category"].stringValue
        advertiseType = json["advertiseType"].stringValue
        digest = json["digest"].stringValue
        docid = json["docid"].stringValue
        articleType = json["articleType"].stringValue
        searchKw = json["searchKw"].arrayValue.compactMap({ InfomationDetailSearchKw(json: $0)})
        hasNext = json["hasNext"].boolValue
        voicecomment = json["voicecomment"].stringValue
        threadVote = json["threadVote"].intValue
        title = json["title"].stringValue
        topiclist = json["topiclist"].arrayValue.compactMap({ InfomationDetailTopiclist(json: $0)})
        ec = json["ec"].stringValue
        dkeys = json["dkeys"].stringValue
        threadAgainst = json["threadAgainst"].intValue
        body = json["body"].stringValue
    }
}

struct InfomationDetailTie {
    var commentIds = [String]()
    
    init(json: JSON) {
        commentIds = json["commentIds"].arrayValue.compactMap({$0.stringValue})
    }
}


struct InfomationDetail352449786 {
    var source: String = ""
    var ip: String = ""
    var productKey: String = ""
    var buildLevel: Int = 0
    var commentId: Int = 0
    var isDel: Bool = false
    var unionState: Bool = false
    var siteName: String = ""
    var createTime: String = ""
    var content: String = ""
    var postId: String = ""
    var anonymous: Bool = false
    var against: Int = 0
    var favCount: Int = 0
    var shareCount: Int = 0
    var vote: Int = 0
    
    init(json: JSON) {
        source = json["source"].stringValue
        ip = json["ip"].stringValue
        productKey = json["productKey"].stringValue
        buildLevel = json["buildLevel"].intValue
        commentId = json["commentId"].intValue
        isDel = json["isDel"].boolValue
        unionState = json["unionState"].boolValue
        siteName = json["siteName"].stringValue
        createTime = json["createTime"].stringValue
        content = json["content"].stringValue
        postId = json["postId"].stringValue
        anonymous = json["anonymous"].boolValue
        against = json["against"].intValue
        favCount = json["favCount"].intValue
        shareCount = json["shareCount"].intValue
        vote = json["vote"].intValue
    }
}

struct InfomationDetailUser {
    var discuzUid: String = ""
    var groupId: Int = 0
    var userBlocked: Bool = false
    var avatar: String = ""
    var kaUid: Int = 0
    var np: String = ""
    var iplayExtcredits3: Int = 0
    var roleName: String = ""
    var location: String = ""
    var medalSlotNum: Int = 0
    var iplayLv: Int = 0
    var userType: Int = 0
    var nu: String = ""
    var nickname: String = ""
    var userId: Int = 0
    
    init(json: JSON) {
        discuzUid = json["discuzUid"].stringValue
        groupId = json["groupId"].intValue
        userBlocked = json["userBlocked"].boolValue
        avatar = json["avatar"].stringValue
        kaUid = json["kaUid"].intValue
        np = json["np"].stringValue
        iplayExtcredits3 = json["iplayExtcredits3"].intValue
        roleName = json["roleName"].stringValue
        location = json["location"].stringValue
        medalSlotNum = json["medalSlotNum"].intValue
        iplayLv = json["iplayLv"].intValue
        userType = json["userType"].intValue
        nu = json["nu"].stringValue
        nickname = json["nickname"].stringValue
        userId = json["userId"].intValue
    }
}

struct InfomationDetail342564304 {
    var source: String = ""
    var ip: String = ""
    var productKey: String = ""
    var buildLevel: Int = 0
    var commentId: Int = 0
    var isDel: Bool = false
    var unionState: Bool = false
    var siteName: String = ""
    var createTime: String = ""
    var content: String = ""
    var postId: String = ""
    var anonymous: Bool = false
    var against: Int = 0
    var favCount: Int = 0
    var shareCount: Int = 0
    var vote: Int = 0
    
    init(json: JSON) {
        source = json["source"].stringValue
        ip = json["ip"].stringValue
        productKey = json["productKey"].stringValue
        buildLevel = json["buildLevel"].intValue
        commentId = json["commentId"].intValue
        isDel = json["isDel"].boolValue
        unionState = json["unionState"].boolValue
        siteName = json["siteName"].stringValue
        createTime = json["createTime"].stringValue
        content = json["content"].stringValue
        postId = json["postId"].stringValue
        anonymous = json["anonymous"].boolValue
        against = json["against"].intValue
        favCount = json["favCount"].intValue
        shareCount = json["shareCount"].intValue
        vote = json["vote"].intValue
    }
}

struct InfomationDetailImg {
    var alt: String = ""
    var pixel: String = ""
    var ref: String = ""
    var src: String = ""
    
    init(json: JSON) {
        alt = json["alt"].stringValue
        pixel = json["pixel"].stringValue
        ref = json["ref"].stringValue
        src = json["src"].stringValue
    }
}

struct InfomationDetailSearchKw {
    var weight: String = ""
    var keyword: String = ""
    var tag_source: Int = 0
    
    init(json: JSON) {
        weight = json["weight"].stringValue
        keyword = json["keyword"].stringValue
        tag_source = json["tag_source"].intValue
    }
}

struct InfomationDetailTopiclist {
    var tname: String = ""
    var cid: String = ""
    var subnum: String = ""
    var alias: String = ""
    var tid: String = ""
    var hasCover: Bool = false
    var ename: String = ""
    
    init(json: JSON) {
        tname = json["tname"].stringValue
        cid = json["cid"].stringValue
        subnum = json["subnum"].stringValue
        alias = json["alias"].stringValue
        tid = json["tid"].stringValue
        hasCover = json["hasCover"].boolValue
        ename = json["ename"].stringValue
    }
}

