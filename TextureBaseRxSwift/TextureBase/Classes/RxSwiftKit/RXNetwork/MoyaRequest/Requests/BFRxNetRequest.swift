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

private let dispose = DisposeBag()

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

    static let shared = BFRxNetRequest()
    private init() {}
    
    // 用来处理只请求一次的栅栏队列
    private let barrierQueue = DispatchQueue(label: "cn.bf.BFRxNetRequest", attributes: .concurrent)
    // 用来处理只请求一次的数组,保存请求的信息 唯一
    private var fetchRequestKeys = [String]()

    // 不带进度条的
    @discardableResult
    func request<T: TargetType & MoyaAddable>(target: T) -> Observable<Response>? {
        
        // 同一请求正在请求直接返回
        if isSameRequest(target) {
            return nil
        }
        
        return Observable<Response>.create({ (observer) -> Disposable in
            
            let provider = self.createProvider(target: target)
            return provider.rx.request(target, callbackQueue: DispatchQueue.global())
                .asObservable()
                .subscribe(onNext: { (result) in
                    DispatchQueue.global().async {
                        observer.onNext(result)
                        DispatchQueue.main.async {
                            observer.onCompleted()
                        }
                    }
                    // 请求完成移除
                    self.cleanRequest(target)
                }, onError: { (error) in
                    DispatchQueue.main.async {
                        observer.onError(error)
                    }
                    // 请求完成移除
                    self.cleanRequest(target)
                })
        })
    }
    
    // 带进度条的
    @discardableResult
    func send<T: TargetType & MoyaAddable>(target: T) -> Observable<ProgressResponse>? {
        
        // 同一请求正在请求直接返回
        if isSameRequest(target) {
            return nil
        }
        
        return Observable<ProgressResponse>.create({ (observer) -> Disposable in
            
            let provider = self.createProvider(target: target)
            // asDriver(onErrorJustReturn: [])
             return provider.rx.requestWithProgress(target, callbackQueue: DispatchQueue.global())
             .asObservable()
             .subscribe(onNext: { (result) in
                
                do {
                    //过滤成功的状态码响应
                    let data = try result.response?.mapJSON()
                    print(data ?? "")
                    //继续做一些其它事情....
                }
                catch {
                    //处理错误状态码的响应...
                }
                DispatchQueue.global().async {
                    observer.onNext(result)
                    DispatchQueue.main.async {
                        observer.onCompleted()
                    }
                }
                // 请求完成移除
                self.cleanRequest(target)
             }, onError: { (error) in
                DispatchQueue.main.async {
                    observer.onError(error)
                }
                // 请求完成移除
                self.cleanRequest(target)
             })
        })
    }

    // 创建moya请求类
    private func createProvider<T: TargetType & MoyaAddable>(target: T) -> MoyaProvider<T> {
        /// 设置请求头,超时时间等
        /*
        let requestClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider<T>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = target.timeOut
                closure(.success(request))
            } catch {
                print("error:", error)
            }
        }
         */
        
        let manager = Manager.default
        manager.session.configuration.timeoutIntervalForRequest = target.timeOut
        
        //  NetworkLoggerPlugin(verbose: false)
        let plugins: [PluginType] = [networkActivityPlugin, BFRxRequestLoadingPlugin(isShowHud: target.isShowHud)]
        return MoyaProvider<T>(manager: manager, plugins: plugins)
    }

    deinit {
        // print("网络请求对象销毁!!!")
    }
    
}

// 保证同一请求同一时间只请求一次
extension BFRxNetRequest {
    private func isSameRequest<R: TargetType & MoyaAddable>(_ type: R) -> Bool {
        switch type.task {
        case let .requestParameters(parameters, _):
            let key = type.path + parameters.description
            var result: Bool = false
            barrierQueue.sync(flags: .barrier) {
                result = fetchRequestKeys.contains(key)
                if !result {
                    // fetchRequestKeys.append(key)
                }
            }
            return result
        default:
            // 不会调用
            return false
        }
    }
    
    private func cleanRequest<R: TargetType & MoyaAddable>(_ type: R) {
        switch type.task {
        case let .requestParameters(parameters, _):
            let key = type.path + parameters.description
            barrierQueue.sync(flags: .barrier) {
                fetchRequestKeys.remove(key)
            }
        default: 
            // 不会调用
            ()
        }
    }
}

