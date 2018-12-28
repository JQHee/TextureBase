//
//  InfomationListViewModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class InfomationListViewModel {
    
    var tableView: ASTableNode?
    var pageIndex = 1
    var info = [InfomationListInfo]()
    
    func list(r: InfomationListRequest, successBlock: @escaping (_ hasMore: Bool) -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in
            
        }, success: { (result) in
            let model = InfomationListModel.init(json: JSON.init(result))
            self.handleSuccessResult(model: model)
            successBlock(model.info.isEmpty ? false : true)
        }, failure: { (error) in
            self.handFailureResult()
            failureBlock()
        }) { (_, error) in
            self.handFailureResult()
            failureBlock()
        }
    }
    
    func handleSuccessResult(model: InfomationListModel) {
        if pageIndex == 1 {
            self.info = model.info
            // self.tableView?.view.mj_footer.isHidden = false
            self.tableView?.view.mj_header.endRefreshing()
        } else {
            self.info += model.info
            if model.info.isEmpty {
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
            info = [InfomationListInfo]()
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
