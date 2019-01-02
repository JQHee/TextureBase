//
//  BFProgressHUD.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/31.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import SVProgressHUD

enum HUDType {
    case success
    case error
    case loading
    case info
    case progress
}

class BFProgressHUD: NSObject {

    class func initProgressHUD() {
        //        SVProgressHUD.setBackgroundColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7))
        //        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
        SVProgressHUD.setDefaultMaskType(.none)
        //        SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 100))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }

    class func showSuccess(_ status: String) {
        self.showProgressHUD(type: .success, status: status)
    }
    class func showError(_ status: String) {
        self.showProgressHUD(type: .error, status: status)
    }
    class func showLoading(_ status: String) {
        self.showProgressHUD(type: .loading, status: status)
    }
    class func showInfo(_ status: String) {
        self.showProgressHUD(type: .info, status: status)
    }
    class func showProgress(_ status: String, _ progress: CGFloat) {
        self.showProgressHUD(type: .success, status: status, progress: progress)
    }
    class func dismissHUD(_ delay: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: delay)
    }

}

extension BFProgressHUD {
    class func showProgressHUD(type: HUDType, status: String, progress: CGFloat = 0) {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
        case .error:
            SVProgressHUD.showError(withStatus: status)
        case .loading:
            SVProgressHUD.show(withStatus: status)
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
        case .progress:
            SVProgressHUD.showProgress(Float(progress), status: status)
        }
    }
}
