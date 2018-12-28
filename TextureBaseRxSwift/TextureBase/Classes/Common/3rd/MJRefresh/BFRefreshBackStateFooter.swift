//
//  ZHFRefreshAutoNormalFooter.swift
//  ZhengHaoFang
//
//  Created by HJQ on 2017/12/12.
//  Copyright © 2017年 Zhenghexing Housing Property Agent Co., Ltd. All rights reserved.
//

import UIKit
import Foundation
import MJRefresh

class BFRefreshBackStateFooter: MJRefreshBackStateFooter {

    var loadingView: UIActivityIndicatorView?
    var bfstateLabel: UILabel?

    var centerOffset:CGFloat = 0

    fileprivate var _noMoreDataStateString:String?
    var noMoreDataStateString:String? {
        get {
            return self._noMoreDataStateString
        }
        set {
            self._noMoreDataStateString = newValue
            self.bfstateLabel?.text = newValue
        }
    }

    override var state:MJRefreshState {
        didSet {
            switch state {
            case .idle:
                self.bfstateLabel?.text = nil
                self.loadingView?.isHidden = true
                self.loadingView?.stopAnimating()
            case .refreshing:
                self.bfstateLabel?.text = nil
                self.loadingView?.isHidden = false
                self.loadingView?.startAnimating()
            case .noMoreData:
                self.bfstateLabel?.text = self.noMoreDataStateString
                self.loadingView?.isHidden = true
                self.loadingView?.stopAnimating()
            default:break
            }
        }
    }

    /**
     初始化工作
     */
    override func prepare() {
        super.prepare()
        self.mj_h = 50

        self.loadingView = UIActivityIndicatorView(style: .white)
        self.addSubview(self.loadingView!)

        self.bfstateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        self.bfstateLabel?.textAlignment = .center
        self.bfstateLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.bfstateLabel!)

        self.noMoreDataStateString = "没有更多数据了"
        self.loadingView?.style = .gray
        self.bfstateLabel?.textColor = UIColor(white: 0, alpha: 0.3)

    }

    /**
     在这里设置子控件的位置和尺寸
     */
    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView!.center = CGPoint(x: self.mj_w/2, y: self.mj_h/2 + self.centerOffset)
        self.bfstateLabel!.center = CGPoint(x: self.mj_w/2, y: self.mj_h/2  + self.centerOffset)
    }

}
