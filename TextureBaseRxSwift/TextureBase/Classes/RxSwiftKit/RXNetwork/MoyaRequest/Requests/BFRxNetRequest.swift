//
//  MYNetRequest.swift
//
//
//  Created by HJQ on 2018/9/18.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Alamofire

typealias RxMoyaTargetType = Moya.TargetType & MoyaAddable

// MARK: - HTTPS Certificate authentication
extension Manager {
    
    static func defaultAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        // get local Certificate authentication
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

public class BFRxNetRequest {

    static let shared = BFRxNetRequest()
    private init() {}
    
    // is request once
    private let barrierQueue = DispatchQueue(label: "cn.bf.BFRxNetRequest", attributes: .concurrent)
    private var fetchRequestKeys = [String]()
    
    // no progress request
    @discardableResult
    func request<T: RxMoyaTargetType>(target: T) -> Observable<Response>? {
        
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
                    self.cleanRequest(target)
                }, onError: { (error) in
                    DispatchQueue.main.async {
                        observer.onError(error)
                    }
                    self.cleanRequest(target)
                })
        })
    }
    
    // progress request
    @discardableResult
    func progressRequest<T: RxMoyaTargetType>(target: T) -> Observable<ProgressResponse>? {
        
        if isSameRequest(target) {
            return nil
        }
        
        let provider = self.createProvider(target: target)
        let progressBlock: (AnyObserver) -> (ProgressResponse) -> Void = { observer in
            return { progress in
                observer.onNext(progress)
            }
        }
        
        let response: Observable<ProgressResponse> = Observable.create { observer in
            let cancellableToken = provider.request(target, callbackQueue: DispatchQueue.global(), progress: progressBlock(observer)) { result in
                switch result {
                case .success:
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
                self.cleanRequest(target)
            }
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
        
        // Accumulate all progress and combine them when the result comes
        // equal redux merge a signal
        return response.scan(ProgressResponse()) { last, progress in
            let progressObject = progress.progressObject ?? last.progressObject
            let response = progress.response ?? last.response
            return ProgressResponse(progress: progressObject, response: response)
        }
    }

    // create moya instance
    private func createProvider<T: RxMoyaTargetType>(target: T) -> MoyaProvider<T> {
        
        /// setting request timeout
        let requestClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider<T>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = target.timeOut
                closure(.success(request))
            } catch {
                print("error:", error)
            }
        }
        
        // log NetworkLoggerPlugin(verbose: false)
        let plugins: [PluginType] = [networkActivityPlugin, BFRxRequestLoadingPlugin(isShowHud: target.isShowHud)]
        return MoyaProvider<T>(requestClosure: requestClosure, manager: Manager.default, plugins: plugins)
    }
    
}

extension BFRxNetRequest {
    
    private func isSameRequest<T: RxMoyaTargetType>(_ target: T) -> Bool {
        switch target.task {
        case let .requestParameters(parameters, _):
            let key = target.path + parameters.description
            var result: Bool = false
            barrierQueue.sync(flags: .barrier) {
                result = fetchRequestKeys.contains(key)
                if !result {
                    // fetchRequestKeys.append(key)
                }
            }
            return result
        default:
            return false
        }
    }
    
    private func cleanRequest<T: RxMoyaTargetType>(_ target: T) {
        switch target.task {
        case let .requestParameters(parameters, _):
            let key = target.path + parameters.description
            barrierQueue.sync(flags: .barrier) {
                fetchRequestKeys.remove(key)
            }
        default:
            ()
        }
    }
}

extension Reactive where Base: BFRxNetRequest {
    
    @discardableResult
    static func sendRequest<T: RxMoyaTargetType>(target: T) -> Observable<Response>? {
        return BFRxNetRequest.shared.request(target: target)
    }
    
    @discardableResult
    static func sendProgressRequest<T: RxMoyaTargetType>(target: T) -> Observable<ProgressResponse>? {
        return BFRxNetRequest.shared.progressRequest(target: target)
    }
    
}

