//
//  MYNetRequest.swift
//  MY_Demo
//
//  Created by magic on 2018/9/18.
//  Copyright © 2018年 magic. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Alamofire

let dispose = DisposeBag()

struct BFRxCustomRequest {
    /* 是否需要指示器 */
    var isActivityIndicator: Bool = true
    /* 请求参数 */
    var parameter: [String:Any]? = nil
    /* 请求超时时间 */
    var timeOut = 15.0
}

// MARK: - HTTPS证书验证
extension Manager {
    
    static func defaultAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        //获取本地证书
        let path: String = Bundle.main.path(forResource: "证书名", ofType: "cer")!
        let certificateData = try? Data(contentsOf: URL(fileURLWithPath: path)) as CFData
        let certificate = SecCertificateCreateWithData(nil, certificateData!)
        let certificates :[SecCertificate] = [certificate!]
        
        let policies: [String: ServerTrustPolicy] = [
            "域名" : .pinCertificates(certificates: certificates, validateCertificateChain: true, validateHost: true)
        ]
        let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
        return manager
    }
}

class BFRxNetRequest {

    var provider: MoyaProvider<ApiManager>

    init(_ custom: BFRxCustomRequest = BFRxCustomRequest()) {
    
        /// 设置请求头,超时时间等
        let requestClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider<ApiManager>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = custom.timeOut
                closure(.success(request))
            } catch {
                print("error:", error)
            }
        }

        let endpointClosure = { (target: Moya.TargetType) -> Endpoint in
            let defaultEndpoint = MoyaProvider<ApiManager>.defaultEndpointMapping(for: target as! ApiManager)
            return defaultEndpoint.adding(newHTTPHeaderFields: ["APP_NAME": "MY_AWESOME_APP"])
        }

        var plugins: [PluginType] = [BFRxRequestLoadingPlugin(custom)]
        if custom.isActivityIndicator {
            plugins = [networkActivityPlugin, BFRxRequestLoadingPlugin(custom)]
        }
        self.provider = MoyaProvider<ApiManager>(endpointClosure: endpointClosure, requestClosure: requestClosure, manager: Manager.default, plugins: plugins)
    }

    // 带进度条的
    @discardableResult
    func request(_ token : Moya.TargetType, callbackQueue: DispatchQueue? = .global()) -> Observable<ProgressResponse> {
        
        return Observable<ProgressResponse>.create({ (observer) -> Disposable in
            // asDriver(onErrorJustReturn: [])
            return self.provider.rx.requestWithProgress(token as! ApiManager, callbackQueue: callbackQueue)
                .asObservable()
                .subscribe(onNext: { (result) in
                    DispatchQueue.global().async {
                        print(result.progressObject ?? "")
                        print(result.response ?? "")
                        observer.onNext(result)
                        DispatchQueue.main.async {
                            observer.onCompleted()
                        }
                    }
                }, onError: { (error) in
                    DispatchQueue.main.async {
                        observer.onError(error)
                    }
                })
        })
    }

    @discardableResult
    func request(_ token : Moya.TargetType, callbackQueue: DispatchQueue? = .global()) -> Observable<BFRxResultModel> {

        return Observable<BFRxResultModel>.create({ (observer) -> Disposable in
            // asDriver(onErrorJustReturn: [])
            return self.provider.rx.request(token as! ApiManager, callbackQueue: callbackQueue)
                .asObservable()
                .mapJSON()
                .mapObject(type: BFRxResultModel.self).subscribe(onNext: { (result) in
                    DispatchQueue.global().async {
                        observer.onNext(result)
                        DispatchQueue.main.async {
                            observer.onCompleted()
                        }
                    }
                }, onError: { (error) in
                    DispatchQueue.main.async {
                        observer.onError(error)
                    }
                })
        })
    }
    

    // MARK: -取消所有请求
    func cancelAllRequest() {
        // MyAPIProvider.manager.session.invalidateAndCancel()  //取消所有请求
        provider.manager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }

    deinit {
        print("网络请求对象销毁!!!")
    }
    
}

//        return Observable<Any>.create({ (observer) -> Disposable in
//            self.provider.rx.request(token as! ApiManager, callbackQueue: callbackQueue)
//                .asObservable()
//                .mapJSON()
//                .subscribe(onNext: { (result) in
//                    observer.onNext(result)
//                }, onError: { (error) in
//                    observer.onError(error)
//                }, onCompleted: {
//                    observer.onCompleted()
//                })
//
//        })
