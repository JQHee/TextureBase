//
//  DiscuListDetailRequest.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

struct DiscuListDetailRequest: Request {

    let version = "163"
    let module = "viewthread"
    let ppp = 20
    let charset = "utf-8"
    var page = 1
    var tid = ""

    var host: String {
        return API.discuList
    }

    var path: String {
        return ""
    }
}
