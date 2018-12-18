//
//  HotRecommentModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/18.
//  Copyright © 2018 ml. All rights reserved.
//

import Foundation

struct HotRecommentModel {
    var printWriter: Bool = false
    var info: HotRecommentInfo = HotRecommentInfo(json: JSON.null)
    var code: Int = 0
    var writeNull: Bool = false

    init(json: JSON) {
        printWriter = json["printWriter"].boolValue
        info = HotRecommentInfo(json: json["info"])
        code = json["code"].intValue
        writeNull = json["writeNull"].boolValue
    }
}

struct HotRecommentInfo {
    // 轮播图
    var focusList = [HotRecommentFocusList]()
    // 分页内容
    var threadList = [HotRecommentThreadList]()
    var forumList = [HotRecommentForumList]()

    init(json: JSON) {
        focusList = json["focusList"].arrayValue.compactMap({ HotRecommentFocusList(json: $0)})
        threadList = json["threadList"].arrayValue.compactMap({ HotRecommentThreadList(json: $0)})
        forumList = json["forumList"].arrayValue.compactMap({ HotRecommentForumList(json: $0)})
    }
}

struct HotRecommentFocusList {
    var url: String = ""
    var img: String = ""
    var tid: String = ""
    var title: String = ""

    init(json: JSON) {
        url = json["url"].stringValue
        img = json["img"].stringValue
        tid = json["tid"].stringValue
        title = json["title"].stringValue
    }
}

struct HotRecommentThreadList {
    var headImg: String = ""
    var fid: String = ""
    var digest: String = ""
    var typename: String = ""
    var replies: String = ""
    var lastpost: String = ""
    var title: String = ""
    var views: String = ""
    var fname: String = ""
    var author: String = ""
    var authorid: String = ""
    var dateline: String = ""
    var tid: String = ""
    var lastposter: String = ""
    var subject: String = ""
    var typeid: String = ""
    var lastposterid: String = ""
    var highlight: String = ""

    init(json: JSON) {
        headImg = json["headImg"].stringValue
        fid = json["fid"].stringValue
        digest = json["digest"].stringValue
        typename = json["typename"].stringValue
        replies = json["replies"].stringValue
        lastpost = json["lastpost"].stringValue
        title = json["title"].stringValue
        views = json["views"].stringValue
        fname = json["fname"].stringValue
        author = json["author"].stringValue
        authorid = json["authorid"].stringValue
        dateline = json["dateline"].stringValue
        tid = json["tid"].stringValue
        lastposter = json["lastposter"].stringValue
        subject = json["subject"].stringValue
        typeid = json["typeid"].stringValue
        lastposterid = json["lastposterid"].stringValue
        highlight = json["highlight"].stringValue
    }
}

struct HotRecommentForumList {
    var title: String = ""
    var fid: String = ""
    var description: String = ""
    var discuzModelTypeId: String = ""
    var icon: String = ""

    init(json: JSON) {
        title = json["title"].stringValue
        fid = json["fid"].stringValue
        description = json["description"].stringValue
        discuzModelTypeId = json["discuzModelTypeId"].stringValue
        icon = json["icon"].stringValue
    }
}

