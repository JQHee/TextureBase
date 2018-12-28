//
//  DiscuListViewModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import SwiftyJSON

class DiscuListViewModel {
    
    var tableView: ASTableNode?
    var pageIndex = 1
    var forum = DiscuListForum(json: JSON.null)
    var topList = [DiscuListForum_threadlist]()
    var threadList = [DiscuListForum_threadlist]()
    
    func list(r: DiscuListRequest, successBlock: @escaping (_ hasMore: Bool) -> (), failureBlock: @escaping () -> ()) {
        HTTPClient.shared.send(r, progressBlock: { (progress) in
            
        }, success: { (result) in
            let info = DiscuListModel.init(json: JSON.init(result)).Variables
            self.handleSuccessResult(info: info)
            successBlock(info.forum_threadlist.isEmpty ? false : true)
        }, failure: { (error) in
            self.handFailureResult()
            failureBlock()
        }) { (_, error) in
            self.handFailureResult()
            failureBlock()
        }
    }
    
    func handleSuccessResult(info: DiscuListVariables) {
        if pageIndex == 1 {
            forum = info.forum
            topList = info.forum_threadlist.filter{$0.displayorder == "1"}
            threadList = info.forum_threadlist.filter{$0.displayorder != "1"}
            // self.tableView?.view.mj_footer.isHidden = false
            self.tableView?.view.mj_header.endRefreshing()
        } else {
            topList += info.forum_threadlist.filter{$0.displayorder == "1"}
            threadList += info.forum_threadlist.filter{$0.displayorder != "1"}
            if info.forum_threadlist.isEmpty {
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
            forum = DiscuListForum(json: JSON.null)
            topList = [DiscuListForum_threadlist]()
            threadList = [DiscuListForum_threadlist]()
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
