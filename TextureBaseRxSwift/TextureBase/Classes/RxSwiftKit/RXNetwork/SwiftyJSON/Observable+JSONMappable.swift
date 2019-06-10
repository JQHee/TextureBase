//
//  Observable+JSONMappable.swift
//  TextureBase
//
//  Created by HJQ on 2019/4/3.
//  Copyright © 2019 ml. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON

public extension ObservableType where E == Response {

    /// Transfrom received data to JSONMappable, fail on error
    func mapJSONMappable<T: JSONMappable>(_ type: T.Type, failsOnEmptyData: Bool = true) -> Observable<T> {
        return flatMap({ (response) -> Observable<T> in
            return Observable<T>.just(try response.mapJSONMappable(type, failsOnEmptyData: failsOnEmptyData))
        })
    }

    /// Transfrom received data to [JSONMappable], fail on error
    func mapJSONMappable<T: JSONMappable>(_ type: [T.Type], failsOnEmptyData: Bool = true) -> Observable<[T]> {
        return flatMap({ (response) -> Observable<[T]> in
            return Observable<[T]>.just(try response.mapJSONMappable(type, failsOnEmptyData: failsOnEmptyData))
        })
    }

}
