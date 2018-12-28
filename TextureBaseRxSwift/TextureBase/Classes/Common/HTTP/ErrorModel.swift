//
//  ErrorModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

class ErrorModel {

    var status: Int = 0
    var message: String = ""

    init(status: Int, message: String) {
        self.status = status
        self.message = message
    }
}
