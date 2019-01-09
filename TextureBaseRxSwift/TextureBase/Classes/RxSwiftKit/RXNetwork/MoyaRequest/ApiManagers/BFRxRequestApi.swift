//
//  MYRequestApi.swift
//  
//
//  Created by HJQ on 2018/9/18.
//  Copyright © 2018年 HJQ. All rights reserved.
//

/*
 * Moya Interface configuration
 */

import Foundation
import Moya

let cachePath = NSHomeDirectory() + "/Library/Caches" + "/MYLazyRequestCache"

// add new protocol
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


extension ApiManager: RxMoyaTargetType {
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var baseURL: URL {
        switch self {
        case .testHome:
            return URL.init(string: "https://douban.fm")!
            
        default:
            return URL.init(string: "")!
        }
    }
    
    var path: String {
        switch self {
        case .testHome:
            return "/j/mine/playlist"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .testHome:
            return .get
            
        default:
            return .post
        }
    }
    
    var task: Task {
        switch self {
         
        case .testHome:
            // return .requestPlain
            var params: [String: Any] = [:]
            params["channel"] = 1
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .testUser(let paramete):
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
        return 20.0
    }
}

 
