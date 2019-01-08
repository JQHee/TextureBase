//
//  Observable+HandyJSON.swift
//  TextureBase
//
//  Created by midland on 2018/12/29.
//  Copyright © 2018年 ml. All rights reserved.
//

import RxSwift
import Moya
import HandyJSON

extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }

}
