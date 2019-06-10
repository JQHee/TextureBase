//
//  Response+JSONMappable.swift
//  TextureBase
//
//  Created by HJQ on 2019/4/3.
//  Copyright © 2019 ml. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

public extension Response {

    // Transfrom received data to JSONMappable
    public func mapJSONMappable<T: JSONMappable>(_ type: T.Type, failsOnEmptyData: Bool = true) throws -> T {
        do {
            let object = try mapJSON(failsOnEmptyData: failsOnEmptyData)
            return T(json: JSON(object))
        } catch {
            if (!failsOnEmptyData) {
                return T(json: JSON.null)
            }
            throw MoyaError.jsonMapping(self)
        }
    }

    // Transfrom received data to [JSONMappable]
    public func mapJSONMappable<T: JSONMappable>(_ type: [T.Type], failsOnEmptyData: Bool = true) throws -> [T] {
        do {
            let object = try mapJSON(failsOnEmptyData: failsOnEmptyData)
            return JSON(object).arrayValue.map({ (json) -> T in
                T(json: json)
            })
        } catch {
            if (!failsOnEmptyData) {
                return [T(json: JSON.null)]
            }
            throw MoyaError.jsonMapping(self)
        }
    }

}
