//
//  DiscuListModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DiscuListModel {
    var Charset: String = ""
    var Variables: DiscuListVariables = DiscuListVariables(json: JSON.null)
    var Version: String = ""
    
    init(json: JSON) {
        Charset = json["Charset"].stringValue
        Variables = DiscuListVariables(json: json["Variables"])
        Version = json["Version"].stringValue
    }
}

struct DiscuListVariables {
    var member_username: String = ""
    var tpp: String = ""
    var saltkey: String = ""
    var ismoderator: String = ""
    var readaccess: String = ""
    var forum: DiscuListForum = DiscuListForum(json: JSON.null)
    var group: DiscuListGroup = DiscuListGroup(json: JSON.null)
    var member_uid: String = ""
    var groupid: String = ""
    var forum_threadlist = [DiscuListForum_threadlist]()
    var cookiepre: String = ""
    var threadtypes: DiscuListThreadtypes = DiscuListThreadtypes(json: JSON.null)
    var member_avatar: String = ""
    var notice: DiscuListNotice = DiscuListNotice(json: JSON.null)
    var page: String = ""
    var formhash: String = ""
    var reward_unit: String = ""
    
    init(json: JSON) {
        member_username = json["member_username"].stringValue
        tpp = json["tpp"].stringValue
        saltkey = json["saltkey"].stringValue
        ismoderator = json["ismoderator"].stringValue
        readaccess = json["readaccess"].stringValue
        forum = DiscuListForum(json: json["forum"])
        group = DiscuListGroup(json: json["group"])
        member_uid = json["member_uid"].stringValue
        groupid = json["groupid"].stringValue
        forum_threadlist = json["forum_threadlist"].arrayValue.compactMap({ DiscuListForum_threadlist(json: $0)})
        cookiepre = json["cookiepre"].stringValue
        threadtypes = DiscuListThreadtypes(json: json["threadtypes"])
        member_avatar = json["member_avatar"].stringValue
        notice = DiscuListNotice(json: json["notice"])
        page = json["page"].stringValue
        formhash = json["formhash"].stringValue
        reward_unit = json["reward_unit"].stringValue
    }
}

struct DiscuListNotice {
    var newmypost: String = ""
    var newpush: String = ""
    var newpm: String = ""
    var newprompt: String = ""
    
    init(json: JSON) {
        newmypost = json["newmypost"].stringValue
        newpush = json["newpush"].stringValue
        newpm = json["newpm"].stringValue
        newprompt = json["newprompt"].stringValue
    }
}



struct DiscuListThreadtypes {
    var prefix: String = ""
    var listable: String = ""
    var required: String = ""
    
    init(json: JSON) {
        prefix = json["prefix"].stringValue
        listable = json["listable"].stringValue
        required = json["required"].stringValue
    }
}

struct DiscuListGroup {
    var groupid: String = ""
    var grouptitle: String = ""
    
    init(json: JSON) {
        groupid = json["groupid"].stringValue
        grouptitle = json["grouptitle"].stringValue
    }
}

struct DiscuListForum {
    var posts: String = ""
    var name: String = ""
    var fid: String = ""
    var password: String = ""
    var todayposts: String = ""
    var threadcount: String = ""
    var picstyle: String = ""
    var fup: String = ""
    var autoclose: String = ""
    var icon: String = ""
    var threads: String = ""
    
    init(json: JSON) {
        posts = json["posts"].stringValue
        name = json["name"].stringValue
        fid = json["fid"].stringValue
        password = json["password"].stringValue
        todayposts = json["todayposts"].stringValue
        threadcount = json["threadcount"].stringValue
        picstyle = json["picstyle"].stringValue
        fup = json["fup"].stringValue
        autoclose = json["autoclose"].stringValue
        icon = json["icon"].stringValue
        threads = json["threads"].stringValue
    }
}

struct DiscuListReply {
    var authorid: String = ""
    var pid: String = ""
    var author: String = ""
    var message: String = ""
    
    init(json: JSON) {
        authorid = json["authorid"].stringValue
        pid = json["pid"].stringValue
        author = json["author"].stringValue
        message = json["message"].stringValue
    }
}

// 列表数据
struct DiscuListForum_threadlist {
    var views: String = ""
    var subject: String = ""
    var authorid: String = ""
    var lastposter: String = ""
    var lastpost: String = ""
    var digest: String = ""
    var replycredit: String = ""
    var dateline: String = ""
    var tid: String = ""
    var rushreply: String = ""
    var readperm: String = ""
    var dbdateline: String = ""
    // 是否为置顶
    var displayorder: String = ""
    var typeid: String = ""
    var dblastpost: String = ""
    var author: String = ""
    var reply = [DiscuListReply]()
    var highlight: String = ""
    var recommend_add: String = ""
    var special: String = ""
    var price: String = ""
    var attachment: String = ""
    var replies: String = ""
    
    init(json: JSON) {
        views = json["views"].stringValue
        subject = json["subject"].stringValue
        authorid = json["authorid"].stringValue
        lastposter = json["lastposter"].stringValue
        lastpost = json["lastpost"].stringValue
        digest = json["digest"].stringValue
        replycredit = json["replycredit"].stringValue
        dateline = json["dateline"].stringValue
        tid = json["tid"].stringValue
        rushreply = json["rushreply"].stringValue
        readperm = json["readperm"].stringValue
        dbdateline = json["dbdateline"].stringValue
        displayorder = json["displayorder"].stringValue
        typeid = json["typeid"].stringValue
        dblastpost = json["dblastpost"].stringValue
        author = json["author"].stringValue
        reply = json["reply"].arrayValue.compactMap({ DiscuListReply(json: $0)})
        highlight = json["highlight"].stringValue
        recommend_add = json["recommend_add"].stringValue
        special = json["special"].stringValue
        price = json["price"].stringValue
        attachment = json["attachment"].stringValue
        replies = json["replies"].stringValue
    }
}

