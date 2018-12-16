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

    var infos: [AWSelectInfo] = [AWSelectInfo]()

    func loadTopData(r: SelectTopRequest, successBlock: @escaping () -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in

        }, success: { (result) in
            print(result)
            successBlock()
        }, failure: { (error) in
            failureBlock()
        }) { (_, error) in
            failureBlock()
        }
    }

    func loadListData(r: SelectRequest, successBlock: @escaping () -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in

        }, success: { (result) in
            self.infos = AWSelectModel.init(json: JSON.init(result)).info
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
