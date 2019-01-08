//
//  ADLaunchView.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ADLaunchView: ASDisplayNode {

    override init() {
        super.init()
        setupUI()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        // 跳过按钮的大小和布局位置
        skipButtonNode.style.preferredSize = CGSize.init(width: 100, height: 30)
        skipButtonNode.style.layoutPosition = CGPoint.init(x: self.bounds.width - 100 - 20, y: 40)

        // 启动图背景
        let insetBackgroundImgSepc = ASInsetLayoutSpec.init(insets: UIEdgeInsets.zero, child: launchImageNode)

        // 广告图
        let insetAdImgSepc = ASInsetLayoutSpec.init(insets: UIEdgeInsets.zero, child: adImageNode)
        let backgroundADImgOverlayLayoutSpec = ASOverlayLayoutSpec.init(child: insetBackgroundImgSepc, overlay: insetAdImgSepc)

        // 跳过按钮
        let absoluteSpec = ASAbsoluteLayoutSpec.init(children: [skipButtonNode])
        let buttonOverlayLayoutSpec = ASOverlayLayoutSpec.init(child: backgroundADImgOverlayLayoutSpec, overlay: absoluteSpec)

        return buttonOverlayLayoutSpec
    }

    // MARK: - Private methods
    private func setupUI() {
        addSubnode(launchImageNode)
        addSubnode(adImageNode)
        addSubnode(skipButtonNode)
        skipButtonNode.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        skipButtonNode.setTitle("跳过", with: UIFont.systemFont(ofSize: 15), with: UIColor.white, for: UIControl.State.normal)
        skipButtonNode.clipsToBounds = true
        skipButtonNode.cornerRadius = 4.0
        skipButtonNode.alpha = 0.92
        
        let path = Bundle.main.path(forResource: "start", ofType: "png") ?? ""
        launchImageNode.image = UIImage.init(contentsOfFile: path)
    }

    override func animateLayoutTransition(_ context: ASContextTransitioning) {

    }

    // MARK: - Lazy load
    lazy var launchImageNode = ASImageNode()
    lazy var adImageNode: ASDisplayNode = {
        return ASDisplayNode.init(viewBlock: { () -> UIView in
            return UIImageView()
        })
    }()
    lazy var skipButtonNode = ASButtonNode()

}
