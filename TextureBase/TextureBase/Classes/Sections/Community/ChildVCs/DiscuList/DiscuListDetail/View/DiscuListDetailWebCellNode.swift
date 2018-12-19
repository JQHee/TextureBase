//
//  DiscuListDetailWebCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DiscuListDetailWebCellNode: ASCellNode {

    private var list: DiscuListDetailPostlist = DiscuListDetailPostlist.init(json: JSON.null)

    func setList(list: DiscuListDetailPostlist, index: Int) {
        self.list = list
        self.iconImageNode.url = URL.init(string: "http://uc.bbs.d.163.com/images/noavatar_middle.gif")
        self.nameNode.attributedText = list.author.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        self.timeNode.attributedText = list.dateline.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        self.countTextNode.attributedText = "\(index)".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
    }

    var webViewHeight: CGFloat = 0

    override init() {
        super.init()
        setupUI()
    }

//    override func calculateSizeThatFits(_ constrainedSize: CGSize) -> CGSize {
//        return CGSize.init(width: constrainedSize.width, height: webViewHeight)
//    }

//    override func calculateLayoutThatFits(_ constrainedSize: ASSizeRange, restrictedTo size: ASLayoutElementSize, relativeToParentSize parentSize: CGSize) -> ASLayout {
//
//    }

    override func layout() {
        super.layout()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        iconImageNode.style.preferredSize = CGSize.init(width: 50, height: 50)

        let nameSpec = ASStackLayoutSpec.horizontal()
        nameSpec.children = [nameNode, timeNode]
        nameSpec.spacing = 10

        let hSpec = ASStackLayoutSpec.horizontal()
        hSpec.justifyContent = .spaceBetween
        hSpec.children = [nameSpec, countTextNode]
        hSpec.alignItems = .end
        hSpec.style.flexGrow = 1

        let contentHSpec = ASStackLayoutSpec.horizontal()
        contentHSpec.children = [iconImageNode, hSpec]
        contentHSpec.spacing = 10

        let contentVSpec = ASStackLayoutSpec.vertical()
        contentVSpec.spacing = 10
        contentVSpec.children = [contentHSpec, webViewNode]

        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentVSpec)
        return insetSpec
    }

    // MARK: - Private methods
    private func setupUI() {
        addSubnode(iconImageNode)
        addSubnode(nameNode)
        addSubnode(timeNode)
        addSubnode(countTextNode)
        addSubnode(webViewNode)
    }

    // MARK: - Lazy load
    lazy var iconImageNode = BFNetworkImageNode()
    lazy var nameNode = ASTextNode()
    lazy var timeNode = ASTextNode()
    lazy var countTextNode = ASTextNode()

    lazy var webViewNode: ASDisplayNode = {
        let view = ASDisplayNode.init(viewBlock: { () -> UIView in
            let webView = UIWebView()
            return webView
        })
        return view
    }()
}

// MARK: - UIWebViewDelegate
extension DiscuListDetailWebCellNode: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.setNeedsLayout()
    }
}
