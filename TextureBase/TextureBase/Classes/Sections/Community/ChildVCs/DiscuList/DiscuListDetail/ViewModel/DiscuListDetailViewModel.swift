//
//  DiscuListDetailViewModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class DiscuListDetailViewModel {

    var tableView: ASTableNode?
    var pageIndex = 1
    var variables = DiscuListDetailVariables(json: JSON.null)
    var list = [DiscuListDetailPostlist]()

    func list(r: DiscuListDetailRequest, successBlock: @escaping (_ hasMore: Bool) -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in

        }, success: { (result) in
            let info = DiscuListDetailModel.init(json: JSON.init(result)).Variables
            self.handleSuccessResult(info: info)
            successBlock(info.postlist.isEmpty ? false : true)
        }, failure: { (error) in
            self.handFailureResult()
            failureBlock()
        }) { (_, error) in
            self.handFailureResult()
            failureBlock()
        }
    }

    func handleSuccessResult(info: DiscuListDetailVariables) {
        if pageIndex == 1 {
            self.variables = info
            self.list = info.postlist
            // self.tableView?.view.mj_footer.isHidden = false
            self.tableView?.view.mj_header.endRefreshing()
        } else {
            self.list += info.postlist
            if info.postlist.isEmpty {
                // self.tableView?.view.mj_footer.isHidden = true
            }
            // self.tableView?.view.mj_footer.endRefreshing()
        }
        UIView.performWithoutAnimation {
            self.tableView?.tn_reloadIndexPaths = self.tableView?.indexPathsForVisibleRows()
            self.tableView?.reloadData()
        }

    }

    func handFailureResult() {
        if pageIndex == 1 {
            self.variables = DiscuListDetailVariables(json: JSON.null)
            self.list = [DiscuListDetailPostlist]()
            // self.tableView?.view.mj_footer.resetNoMoreData()
            self.tableView?.view.mj_header.endRefreshing()
        } else {
            pageIndex -= 1
            self.tableView?.view.mj_header.endRefreshing()
            // self.tableView?.view.mj_footer.endRefreshing()
        }
        UIView.performWithoutAnimation {
            self.tableView?.tn_reloadIndexPaths = self.tableView?.indexPathsForVisibleRows()
            self.tableView?.reloadData()
        }
    }

}
