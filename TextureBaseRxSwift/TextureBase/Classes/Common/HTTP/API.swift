//
//  API.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 通用
struct API {
    
    static let baseURL = "http://i.play.163.com"
    static let adImage = "/news/initLogo/ios_iphone6"

}

// MARK: - 精选
extension API {
    static let selectTop = "/news/topicOrderSource/list"
    static let selectList = "/news/config/config_focus_img/list/"
}

// MARK: - 社区
extension API {
    // 热门推荐
    static let hotRecomment = "/news/discuz/forum_recommend_detail"
    // 凯恩之角
    static let kaneList = "/news/discuz/discuz_model_v2/list/center/1"
    // 爱玩社区
    static let lovePlayList = "/news/discuz/discuz_model_v2/list/center/0"
    // 论坛列表
    static let discuList = "http://bbs.d.163.com/api/mobile/index.php"
    // 论坛列表顶部的图片（待接入）
    static let discuListHeaderImg = "/news/discuz/discuz_model/fid_img"
}

// MAKR: - 资讯
extension API {
    // 资讯列表
    static let infomationList = "/user/article/list/"
    // 资讯详情
    static let infomationDetail = "/news/appDetail/"
}
