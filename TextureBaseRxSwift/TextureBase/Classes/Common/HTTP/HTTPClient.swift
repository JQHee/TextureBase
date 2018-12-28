//
//  HTTPClient.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import Alamofire

/// 请求成功
typealias RequestSucceed = (_ result: [String: AnyObject]) -> Void
/// 请求失败
typealias RequestFailure = (_ error: Error) -> Void
/// 请求错误回调
typealias RequestError   = (_ result: [String: AnyObject], _ errorObject: ErrorModel) -> Void
/// 上传进度
typealias RequestProgress = (_ progress: Progress) -> Void

class HTTPClient {

    static let shared = HTTPClient()
    private init() {}

    private func getRequestMethod(type: HTTPRequestMethod) -> HTTPMethod {
        switch type {
        case .POST:
            return HTTPMethod.post
        case .GET:
            return HTTPMethod.get

        }
    }

    // MARK: - lazy load
    private lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        // 设置请求超时时间
        configuration.timeoutIntervalForRequest = 15
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
}

// MARK: - 基本的网络请求
extension HTTPClient {

    // 普通的网络请求
    func send(_ r: Request, progressBlock: @escaping RequestProgress, success: @escaping RequestSucceed, failure: @escaping RequestFailure, requestError: @escaping RequestError) {
        if r.hud {}

        print("请求链接:\(r.host + r.path)")
        print("请求参数:\( r.parameters ?? [:] )")
        
        let httpMethod = getRequestMethod(type: r.method )
        sessionManager.session.configuration.timeoutIntervalForRequest = r.timeOut
        sessionManager.request(r.host + r.path, method: httpMethod, parameters: r.parameters, headers: r.normalHeaders).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            print("Progress: \(progress.fractionCompleted)")
            progressBlock(progress)

            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                switch response.result {
                case .success(_):

                    //debugLog(response.result.value)
                    if let value = response.result.value as? [String: AnyObject] {
                        success(value)
                        return
                    }
                    // 未知错误
                    let m = ErrorModel(status: -11211, message: "数据格式不正确")
                    requestError([:], m)
                case .failure(let error):
                    failure(error)
                }
        }
    }

    // 普通的网络请求
    func sendRequest(_ r: Request, progressBlock: @escaping RequestProgress, success: @escaping RequestSucceed, failure: @escaping RequestFailure, requestError: @escaping RequestError) {
        if r.hud {}

        print("请求链接:\(r.host + r.path)")
        print("请求参数:\( r.parameters ?? [:] )")

        let httpMethod = getRequestMethod(type: r.method )
        sessionManager.session.configuration.timeoutIntervalForRequest = r.timeOut
        sessionManager.request(r.host + r.path, method: httpMethod, parameters: r.parameters, headers: r.normalHeaders).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            print("Progress: \(progress.fractionCompleted)")
            progressBlock(progress)

            }
            .validate { request, response, data in
                return .success
            }.responseString { (response) in
                guard var covarntentStr: String = response.result.value else{
                    return
                }
                // 去除首尾的引号
                let characterSet = CharacterSet(charactersIn: "\"")
                covarntentStr = covarntentStr.trimmingCharacters(in: characterSet)
                let content = ["content": String(covarntentStr)]
                success(content as [String : AnyObject])
        }
    }

}
