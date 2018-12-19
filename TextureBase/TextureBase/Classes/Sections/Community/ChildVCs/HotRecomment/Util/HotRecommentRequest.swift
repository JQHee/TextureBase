//
//  HotRecommentRequest.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/18.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

struct HotRecommentRequest: Request {

    var pageIndex = 1
    var pageSize = 20

    var path: String {
        return API.hotRecomment + "/" + String(pageIndex) + "/" + String(pageSize)
    }

    var parameters: [String : Any]? {
        return [:]
    }


}
