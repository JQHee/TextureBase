//
//  AWSelectModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AWSelectModel {
    var info = [AWSelectInfo]()
    var code: Int = 0
    var writeNull: Bool = false

    init(json: JSON) {
        info = json["info"].arrayValue.compactMap({ AWSelectInfo(json: $0)})
        code = json["code"].intValue
        writeNull = json["writeNull"].boolValue
    }
}

struct AWSelectInfo {
    var docid: String = ""
    var subtitleTwo: String = ""
    var subtitleOne: String = ""
    var address: String = ""
    var imgUrl: String = ""
    var title: String = ""
    var priority: Int = 0

    init(json: JSON) {
        docid = json["docid"].stringValue
        subtitleTwo = json["subtitleTwo"].stringValue
        subtitleOne = json["subtitleOne"].stringValue
        address = json["address"].stringValue
        imgUrl = json["imgUrl"].stringValue
        title = json["title"].stringValue
        priority = json["priority"].intValue
    }
}

