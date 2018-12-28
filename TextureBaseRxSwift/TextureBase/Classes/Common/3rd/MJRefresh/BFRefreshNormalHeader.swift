//
//  ZHFRefreshNormalHeader.swift
//  ZhengHaoFang
//
//  Created by HJQ on 2017/12/12.
//  Copyright © 2017年 Zhenghexing Housing Property Agent Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh

class BFRefreshNormalHeader: MJRefreshNormalHeader {

    var loadingView: UIActivityIndicatorView?
    var arrowImage: UIImageView?
    
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                self.loadingView?.isHidden = true
                self.arrowImage?.isHidden = false
                self.loadingView?.stopAnimating()
            case .pulling:
                self.loadingView?.isHidden = false
                self.arrowImage?.isHidden = true
                self.loadingView?.startAnimating()
                
            case .refreshing:
                self.loadingView?.isHidden = false
                self.arrowImage?.isHidden = true
                self.loadingView?.startAnimating()
            default:
                print("")
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
        
        self.arrowImage = UIImageView(image: UIImage.init(named: "ic_arrow_downward"))
        self.addSubview(self.arrowImage!)
        self.loadingView?.style = .white
        self.arrowImage?.tintColor = UIColor.gray
    }
    
    /**
     在这里设置子控件的位置和尺寸
     */
    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView!.center = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
        self.arrowImage!.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        self.arrowImage!.center = self.loadingView!.center
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable: Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable: Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable: Any]!) {
        super.scrollViewPanStateDidChange(change)
    }

}
