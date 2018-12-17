//
//  SelectViewModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class SelectViewModel {

    // 广告
    var infos: [AWSelectInfo] = [AWSelectInfo]()
    // 列表
    var listInfos: [AWSelectListInfo] = [AWSelectListInfo]()

    func loadTopData(r: SelectTopRequest, successBlock: @escaping () -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in

        }, success: { (result) in
            self.listInfos = AWSelectListModel.init(json: JSON.init(result)).info
            print(result)
            successBlock()
        }, failure: { (error) in
            self.listInfos = [AWSelectListInfo]()
            failureBlock()
        }) { (_, error) in
            self.listInfos = [AWSelectListInfo]()
            failureBlock()
        }
    }

    func loadListData(r: SelectRequest, successBlock: @escaping () -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in

        }, success: { (result) in
            self.infos = AWSelectModel.init(json: JSON.init(result)).info
            print(result)
            successBlock()
        }, failure: { (error) in
            self.infos = [AWSelectInfo]()
            failureBlock()
        }) { (_, error) in
            self.infos = [AWSelectInfo]()
            failureBlock()
        }
    }
}
