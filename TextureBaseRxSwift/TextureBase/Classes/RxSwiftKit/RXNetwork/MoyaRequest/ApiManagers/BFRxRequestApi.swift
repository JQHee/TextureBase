//
//  MYRequestApi.swift
//  MY_Demo
//
//  Created by magic on 2018/9/18.
//  Copyright © 2018年 magic. All rights reserved.
//

/*
 * Moya 网络请求,各个接口配置,集中管理快捷方便
 */

import Foundation
import Moya

let cachePath = NSHomeDirectory() + "/Library/Caches" + "/MYLazyRequestCache"

protocol MoyaAddable {
    var cacheKey: String? { get }
    var isShowHud: Bool { get }
    var timeOut: Double { get }
}

enum ApiManager {
    case testHome
    case testUser([String: Any])
    case testUserapi([String: Any])
}

/// 执行代理
extension ApiManager: Moya.TargetType, MoyaAddable {
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var baseURL: URL {
        switch self {
        case .testHome:
            return URL.init(string: "http://www.baidu.com")!
            
        default:
            return URL.init(string: "")!
        }
    }
    
    var path: String {
        switch self {
        case .testHome:
            return ""
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .testHome:
            return .post
            
        default:
            return .post
        }
    }
    
    var task: Task {
        switch self {
         
        case .testUser(let paramete):
            // url 请求参数
            // Task.requestCompositeParameters(bodyParameters: <#T##[String : Any]#>, bodyEncoding: <#T##ParameterEncoding#>, urlParameters: <#T##[String : Any]#>)
            return .requestParameters(parameters: paramete, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var cacheKey: String? {
        return ""
    }
    
    var isShowHud: Bool {
        return true
    }
    
    var timeOut: Double {
        return 15.0
    }
}

 
