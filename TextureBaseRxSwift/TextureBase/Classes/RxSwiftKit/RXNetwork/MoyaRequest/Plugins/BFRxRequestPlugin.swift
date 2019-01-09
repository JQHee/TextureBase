//
//  MYRequestPlugin.swift
//  
//
//  Created by HJQ on 2018/9/18.
//  Copyright © 2018年 HJQ. All rights reserved.
//

/*
 * Plugins
 */

import Foundation
import Moya
import Result

/// setting request NetworkActivity
let networkActivityPlugin = NetworkActivityPlugin { (change, targeType) in

        switch(change){
        case .ended:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
           
        case .began:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }

        }
}

public final class BFRxRequestLoadingPlugin: PluginType {
    
    var isShowHud: Bool = false
    
    init(isShowHud: Bool) {
        self.isShowHud = isShowHud
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        // print("request start")
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        // print("request end")
    }
}
