//
//  SelectRequest.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

struct SelectRequest: Request {
    var path: String {
        return API.selectList
    }
}
