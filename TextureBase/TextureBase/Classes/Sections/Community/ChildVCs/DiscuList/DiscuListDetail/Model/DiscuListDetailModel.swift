//
//  DiscuListDetailModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import Foundation
import SwiftyJSON
import TYAttributedLabel

class DiscuListDetailModel {
    var Variables: DiscuListDetailVariables = DiscuListDetailVariables(json: JSON.null)
    var Charset: String = ""
    var Version: String = ""

    init(json: JSON) {
        Variables = DiscuListDetailVariables(json: json["Variables"])
        Charset = json["Charset"].stringValue
        Version = json["Version"].stringValue
    }
}

class DiscuListDetailVariables {
    var thread: DiscuListDetailThread = DiscuListDetailThread(json: JSON.null)
    var ppp: String = ""
    var cache_custominfo_postno = [String]()
    var notice: DiscuListDetailNotice = DiscuListDetailNotice(json: JSON.null)
    var forum_threadpay: String = ""
    var cookiepre: String = ""
    var setting_rewritestatus = [String]()
    var saltkey: String = ""
    var member_uid: String = ""
    var ismoderator: String = ""
    var fid: String = ""
    var groupid: String = ""
    var member_avatar: String = ""
    var postlist = [DiscuListDetailPostlist]()
    var member_username: String = ""
    var readaccess: String = ""
    var forum: DiscuListDetailForum = DiscuListDetailForum(json: JSON.null)
    var allowpostcomment = [String]()
    var allowgetattach: String = ""
    var allowgetimage: String = ""
    var setting_rewriterule: DiscuListDetailSetting_rewriterule = DiscuListDetailSetting_rewriterule(json: JSON.null)
    var formhash: String = ""

    init(json: JSON) {
        thread = DiscuListDetailThread(json: json["thread"])
        ppp = json["ppp"].stringValue
        cache_custominfo_postno = json["cache_custominfo_postno"].arrayValue.compactMap({$0.stringValue})
        notice = DiscuListDetailNotice(json: json["notice"])
        forum_threadpay = json["forum_threadpay"].stringValue
        cookiepre = json["cookiepre"].stringValue
        setting_rewritestatus = json["setting_rewritestatus"].arrayValue.compactMap({$0.stringValue})
        saltkey = json["saltkey"].stringValue
        member_uid = json["member_uid"].stringValue
        ismoderator = json["ismoderator"].stringValue
        fid = json["fid"].stringValue
        groupid = json["groupid"].stringValue
        member_avatar = json["member_avatar"].stringValue
        postlist = json["postlist"].arrayValue.compactMap({ DiscuListDetailPostlist(json: $0)})
        member_username = json["member_username"].stringValue
        readaccess = json["readaccess"].stringValue
        forum = DiscuListDetailForum(json: json["forum"])
        allowpostcomment = json["allowpostcomment"].arrayValue.compactMap({$0.stringValue})
        allowgetattach = json["allowgetattach"].stringValue
        allowgetimage = json["allowgetimage"].stringValue
        setting_rewriterule = DiscuListDetailSetting_rewriterule(json: json["setting_rewriterule"])
        formhash = json["formhash"].stringValue
    }
}

class DiscuListDetailSetting_rewriterule {
    var forum_forumdisplay: String = ""
    var portal_topic: String = ""
    var plugin: String = ""
    var forum_viewthread: String = ""
    var group_group: String = ""
    var portal_article: String = ""
    var home_space: String = ""
    var home_blog: String = ""
    var forum_archiver: String = ""

    init(json: JSON) {
        forum_forumdisplay = json["forum_forumdisplay"].stringValue
        portal_topic = json["portal_topic"].stringValue
        plugin = json["plugin"].stringValue
        forum_viewthread = json["forum_viewthread"].stringValue
        group_group = json["group_group"].stringValue
        portal_article = json["portal_article"].stringValue
        home_space = json["home_space"].stringValue
        home_blog = json["home_blog"].stringValue
        forum_archiver = json["forum_archiver"].stringValue
    }
}

class DiscuListDetailForum {
    var password: String = ""

    init(json: JSON) {
        password = json["password"].stringValue
    }
}

class DiscuListDetailNotice {
    var newpush: String = ""
    var newpm: String = ""
    var newprompt: String = ""
    var newmypost: String = ""

    init(json: JSON) {
        newpush = json["newpush"].stringValue
        newpm = json["newpm"].stringValue
        newprompt = json["newprompt"].stringValue
        newmypost = json["newmypost"].stringValue
    }
}

class DiscuListDetailThread {
    var isgroup: String = ""
    var dateline: String = ""
    var rate: String = ""
    var threadtableid: String = ""
    var posttable: String = ""
    var relatebytag: String = ""
    var relay: String = ""
    var displayorder: String = ""
    var posttableid: String = ""
    var allreplies: String = ""
    var pushedaid: String = ""
    var closed: String = ""
    var ordertype: String = ""
    var bgcolor: String = ""
    var comments: String = ""
    var moderated: String = ""
    var stamp: String = ""
    var replycredit: String = ""
    var special: String = ""
    var recommends: String = ""
    var readperm: String = ""
    var threadtable: String = ""
    var highlight: String = ""
    var cover: String = ""
    var subjectenc: String = ""
    var archiveid: String = ""
    var attachment: String = ""
    var authorid: String = ""
    var heats: String = ""
    var tid: String = ""
    var maxposition: String = ""
    var lastpost: String = ""
    var stickreply: String = ""
    var author: String = ""
    var replies: String = ""
    var short_subject: String = ""
    var price: String = ""
    var sortid: String = ""
    var fid: String = ""
    var heatlevel: String = ""
    var lastposter: String = ""
    var typeid: String = ""
    var hidden: String = ""
    var recommend_add: String = ""
    var recommend_sub: String = ""
    var addviews: String = ""
    var recommend: String = ""
    var views: String = ""
    var icon: String = ""
    var is_archived: String = ""
    var favtimes: String = ""
    var subject: String = ""
    var digest: String = ""
    var status: String = ""
    var recommendlevel: String = ""
    var sharetimes: String = ""
    var typename: String = ""

    init(json: JSON) {
        isgroup = json["isgroup"].stringValue
        dateline = json["dateline"].stringValue
        rate = json["rate"].stringValue
        threadtableid = json["threadtableid"].stringValue
        posttable = json["posttable"].stringValue
        relatebytag = json["relatebytag"].stringValue
        relay = json["relay"].stringValue
        displayorder = json["displayorder"].stringValue
        posttableid = json["posttableid"].stringValue
        allreplies = json["allreplies"].stringValue
        pushedaid = json["pushedaid"].stringValue
        closed = json["closed"].stringValue
        ordertype = json["ordertype"].stringValue
        bgcolor = json["bgcolor"].stringValue
        comments = json["comments"].stringValue
        moderated = json["moderated"].stringValue
        stamp = json["stamp"].stringValue
        replycredit = json["replycredit"].stringValue
        special = json["special"].stringValue
        recommends = json["recommends"].stringValue
        readperm = json["readperm"].stringValue
        threadtable = json["threadtable"].stringValue
        highlight = json["highlight"].stringValue
        cover = json["cover"].stringValue
        subjectenc = json["subjectenc"].stringValue
        archiveid = json["archiveid"].stringValue
        attachment = json["attachment"].stringValue
        authorid = json["authorid"].stringValue
        heats = json["heats"].stringValue
        tid = json["tid"].stringValue
        maxposition = json["maxposition"].stringValue
        lastpost = json["lastpost"].stringValue
        stickreply = json["stickreply"].stringValue
        author = json["author"].stringValue
        replies = json["replies"].stringValue
        short_subject = json["short_subject"].stringValue
        price = json["price"].stringValue
        sortid = json["sortid"].stringValue
        fid = json["fid"].stringValue
        heatlevel = json["heatlevel"].stringValue
        lastposter = json["lastposter"].stringValue
        typeid = json["typeid"].stringValue
        hidden = json["hidden"].stringValue
        recommend_add = json["recommend_add"].stringValue
        recommend_sub = json["recommend_sub"].stringValue
        addviews = json["addviews"].stringValue
        recommend = json["recommend"].stringValue
        views = json["views"].stringValue
        icon = json["icon"].stringValue
        is_archived = json["is_archived"].stringValue
        favtimes = json["favtimes"].stringValue
        subject = json["subject"].stringValue
        digest = json["digest"].stringValue
        status = json["status"].stringValue
        recommendlevel = json["recommendlevel"].stringValue
        sharetimes = json["sharetimes"].stringValue
        typename = json["typename"].stringValue
    }
}

class DiscuListDetailPostlist {
    var groupid: String = ""
    var anonymous: String = ""
    var message: String = ""
    var allowshowreply: String = ""
    var author: String = ""
    var number: String = ""
    var allowshowcomment: String = ""
    var first: String = ""
    var username: String = ""
    var replycredit: String = ""
    var authorid: String = ""
    var allowshowedit: String = ""
    var dbdateline: String = ""
    var position: String = ""
    var allowshowreport: String = ""
    var pid: String = ""
    var groupiconid: String = ""
    var memberstatus: String = ""
    var adminid: String = ""
    var status: String = ""
    var dateline: String = ""
    var attachment: String = ""
    var tid: String = ""
    var textContainer: TYTextContainer = TYTextContainer()

    init(json: JSON) {
        groupid = json["groupid"].stringValue
        anonymous = json["anonymous"].stringValue
        message = json["message"].stringValue
        allowshowreply = json["allowshowreply"].stringValue
        author = json["author"].stringValue
        number = json["number"].stringValue
        allowshowcomment = json["allowshowcomment"].stringValue
        first = json["first"].stringValue
        username = json["username"].stringValue
        replycredit = json["replycredit"].stringValue
        authorid = json["authorid"].stringValue
        allowshowedit = json["allowshowedit"].stringValue
        dbdateline = json["dbdateline"].stringValue
        position = json["position"].stringValue
        allowshowreport = json["allowshowreport"].stringValue
        pid = json["pid"].stringValue
        groupiconid = json["groupiconid"].stringValue
        memberstatus = json["memberstatus"].stringValue
        adminid = json["adminid"].stringValue
        status = json["status"].stringValue
        dateline = json["dateline"].stringValue
        attachment = json["attachment"].stringValue
        tid = json["tid"].stringValue
        let text = BFPostTextParser.replaceXMLLabelWithText(text: message as NSString)
        textContainer = BFPostTextParser.parserPostText(text: text as NSString)
    }
}

