//
//  CustomeactivityIndicatorCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/11.
//  Copyright © 2018 ml. All rights reserved.
//

/**
* 添加一个 UIActivityIndicatorView 到 ASCellNode
 */

import UIKit
import AsyncDisplayKit

class CustomeactivityIndicatorCellNode: ASCellNode {


    override init() {
        super.init()
        addSubnode(activityIndicator)

    }

    // 使用 resume 方法调用 startAnimating
    func resume() {
        startAnimating()
    }

    func startAnimating() {
        if let activityIndicatorView = activityIndicator.view as? UIActivityIndicatorView {
            activityIndicatorView.startAnimating()
        }
    }

    override func calculateSizeThatFits(_ constrainedSize: CGSize) -> CGSize {
        return CGSize(width: constrainedSize.width, height: 44)
    }

    override func layout() {
        activityIndicator.frame = CGRect(x: self.calculatedSize.width / 2.0 - 22.0, y: 11, width: 44, height: 44)
    }


    let activityIndicator: ASDisplayNode = ASDisplayNode { () -> UIView in
        let view = UIActivityIndicatorView(style: .gray)
        view.backgroundColor = UIColor.clear
        view.hidesWhenStopped = true
        return view
    }

}
