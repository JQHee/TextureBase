//
//  DiscuListRequest.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

struct DiscuListRequest: Request {
    
    let version = "163"
    let module = "forumdisplay"
    let tpp = 15
    let charset = "utf-8"
    var page = 1
    var fid = ""
    
    var host: String {
        return API.discuList
    }
    
    var path: String {
        return ""
    }
}
