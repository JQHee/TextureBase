//
//  Observable+SwiftyJSON.swift
//  TextureBase
//
//  Created by midland on 2018/12/29.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON


/*
.mapJson({
    return JSON($0)["data"]
})
 */
extension ObservableType where E == Any {
    public func mapJson(_ json : @escaping ((E) -> JSON)) -> Observable<Any> {
        return flatMap { (result) -> Observable<Any> in
            return Observable.just(json(result).object)
        }
    }
}
