//
//  KaneViewModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/18.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class KaneViewModel {

    var discuzList: [KaneDiscuzList] = [KaneDiscuzList]()
    
    // 请求kane之角列表数据
    func loadList(r: KaneRequest, successBlock: @escaping () -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in
            
        }, success: { (result) in
           self.discuzList = KaneModel.init(json: JSON.init(result)).info.discuzList
            print(result)
            successBlock()
        }, failure: { (error) in
            self.discuzList = [KaneDiscuzList]()
            failureBlock()
        }) { (_, error) in
            self.discuzList = [KaneDiscuzList]()
            failureBlock()
        }
    }
    
    // 爱玩社区
    func looadLovePlayCommunity(r: LovePlayCommunityRequest, successBlock: @escaping () -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in
            
        }, success: { (result) in
            self.discuzList = KaneModel.init(json: JSON.init(result)).info.discuzList
            print(result)
            successBlock()
        }, failure: { (error) in
            self.discuzList = [KaneDiscuzList]()
            failureBlock()
        }) { (_, error) in
            self.discuzList = [KaneDiscuzList]()
            failureBlock()
        }
    }
}
