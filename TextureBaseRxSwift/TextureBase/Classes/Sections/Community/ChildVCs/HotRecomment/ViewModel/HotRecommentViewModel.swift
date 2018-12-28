//
//  HotRecommentViewModel.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/18.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotRecommentViewModel {

    var tableView: ASTableNode?
    var pageIndex = 1
    var focusList = [HotRecommentFocusList]()
    var threadList = [HotRecommentThreadList]()

    func list(r: HotRecommentRequest, successBlock: @escaping (_ hasMore: Bool) -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in

        }, success: { (result) in
            let info = HotRecommentModel.init(json: JSON.init(result)).info
            self.handleSuccessResult(info: info)
            successBlock(info.threadList.isEmpty ? false : true)
        }, failure: { (error) in
            self.handFailureResult()
            failureBlock()
        }) { (_, error) in
            self.handFailureResult()
            failureBlock()
        }
    }

    func handleSuccessResult(info: HotRecommentInfo) {
        if pageIndex == 1 {
            focusList = info.focusList
            threadList = info.threadList
            // self.tableView?.view.mj_footer.isHidden = false
            self.tableView?.view.mj_header.endRefreshing()
        } else {
            threadList += info.threadList
            if info.threadList.isEmpty {
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
            focusList = [HotRecommentFocusList]()
            threadList = [HotRecommentThreadList]()
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
