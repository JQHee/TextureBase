//
//  MYRequestPlugin.swift
//  MY_Demo
//
//  Created by magic on 2018/9/18.
//  Copyright © 2018年 magic. All rights reserved.
//

/*
 * 网络请求插件
 */

import Foundation
import Moya
import Result

/// 设置网络请求导航栏小菊花
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

/// 此类不允许继承
public final class BFRxRequestLoadingPlugin: PluginType {
    
    var isShowHud: Bool = false
    
    init(isShowHud: Bool) {
        self.isShowHud = isShowHud
        ///初始化 hud
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        // print("请求开始")
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        // print("结束请求")
    }
    
    deinit {
        // print("插件销毁!!!")
    }
}
