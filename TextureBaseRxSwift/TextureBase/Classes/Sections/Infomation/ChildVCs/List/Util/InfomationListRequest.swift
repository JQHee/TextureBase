//
//  InfomationListRequest.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

struct InfomationListRequest: Request {

    var topId = ""
    var pageIndex = 1
    var pageSize = 20
    
    var path: String {
        return API.infomationList + topId + "/" + String(pageIndex) + "/" + String(pageSize)
    }
    
    var parameters: [String : Any]? {
        return [:]
    }
}
