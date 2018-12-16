//
//  ADLaunchViewModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class ADLaunchViewModel: NSObject {

    var imgURL: String = ""
    // 获取广告
    func requestImg(r: ADLaunchRequest, successBlock: @escaping () -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.sendRequest(r, progressBlock: { (progress) in

        }, success: { (result) in
            self.imgURL = JSON.init(result)["content"].stringValue
            successBlock()
        }, failure: { (error) in
            failureBlock()
        }) { (_, error) in
            failureBlock()
        }
    }
}
