//
//  MJRefresh-Extension.swift
//  Swift_baseFramework
//
//  Created by HJQ on 2018/4/10.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import MJRefresh

// MARK: - 上下拉刷新
extension UIScrollView {
    
    /// 设置上拉，下拉刷新
    ///
    /// - Parameters:
    ///   - isNeedFooterRefresh: 是否需要上拉刷新
    ///   - headerCallback: 上拉刷新回调
    ///   - footerCallBack: 下拉刷新回调
    func setupRefresh(isNeedFooterRefresh: Bool = true, headerCallback: (() -> Void)?, footerCallBack: (() -> Void)?) {

        if let callback = headerCallback {
            self.mj_header = BFRefreshNormalHeader(refreshingBlock: { [weak self] in
                if isNeedFooterRefresh {
                    self?.mj_footer.resetNoMoreData()
                }
                callback()
            })
        }

        if isNeedFooterRefresh {
            if let callback = footerCallBack {
                let footer =  BFRefreshBackStateFooter.init(refreshingBlock: {
                    callback()
                })
                footer?.setTitle("已显示全部内容", for: MJRefreshState.noMoreData)
                self.mj_footer = footer
            }
        }
    }

}
