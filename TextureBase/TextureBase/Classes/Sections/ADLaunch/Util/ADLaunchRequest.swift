//
//  ADLaunchRequest.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

struct ADLaunchRequest: Request {
    var path: String {
        return API.adImage
    }

    var normalHeaders: [String: String] {
        // 2.自定义头部
        let headers: [String: String] = [
            "Accept": "text/json"
        ]
        return headers
    }
    
    var timeOut: TimeInterval {
        return 2.0
    }
}
