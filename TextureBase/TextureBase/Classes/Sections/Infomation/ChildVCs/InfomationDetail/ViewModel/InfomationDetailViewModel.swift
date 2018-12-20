//
//  InfomationDetailViewModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/20.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class InfomationDetailViewModel {
    
    var info = InfomationDetailInfo(json: JSON.null)
    
    func list(r: InfomationDetailRequest, successBlock: @escaping (_ hasMore: Bool) -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in
            
        }, success: { (result) in
            self.info = InfomationDetailModel.init(json: JSON.init(result)).info
            successBlock(true)
        }, failure: { (error) in
            self.info = InfomationDetailInfo(json: JSON.null)
            failureBlock()
        }) { (_, error) in
            self.info = InfomationDetailInfo(json: JSON.null)
            failureBlock()
        }
    }
    
}
