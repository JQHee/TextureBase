//
//  InfomationDetailRequest.swift
//  TextureBase
//
//  Created by midland on 2018/12/20.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

struct InfomationDetailRequest: Request {
    
    var newId = ""
    let tieVersion = "v2"
    let platform = "ios"
    let width = kScreenW * 2.0
    let height = kScreenH * 2.0
    let decimal = 75

    var path: String {
        return API.infomationDetail + newId
    }
}
