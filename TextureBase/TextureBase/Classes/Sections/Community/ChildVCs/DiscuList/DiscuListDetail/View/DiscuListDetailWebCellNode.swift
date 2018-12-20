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
        

        dispatch_async_safely_main_queue {
            guard let webView = self.webViewNode.view as? UIWebView else {
                return
            }
            guard let url = URL.init(string: "https://www.baidu.com") else {
                return
            }
            webView.loadRequest(URLRequest.init(url: url))
        }
      
    }

    var webViewHeight: CGFloat = 0

    override init() {
        super.init()
        setupUI()

    }

//    override func calculateSizeThatFits(_ constrainedSize: CGSize) -> CGSize {
//        return CGSize.init(width: constrainedSize.width, height: 500)
//    }
//
//    override func calculateLayoutThatFits(_ constrainedSize: ASSizeRange, restrictedTo size: ASLayoutElementSize, relativeToParentSize parentSize: CGSize) -> ASLayout {
//
//        let layout = ASLayout()
//        return layout
//    }

    override func layout() {
        super.layout()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        iconImageNode.style.preferredSize = CGSize.init(width: 50, height: 50)
        webViewNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: webViewHeight == 0 ? 0.001 : webViewHeight)

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
        

        dispatch_async_safely_main_queue {
            guard let webView = self.webViewNode.view as? UIWebView else {
                return
            }
            webView.scrollView.isScrollEnabled = false
            webView.scrollView.scrollsToTop = false
            webView.delegate = self
            webView.backgroundColor = UIColor.init(red: 247.0/255, green: 247.0/255, blue: 247.0/255, alpha: 1.0)
            webView.scalesPageToFit = false
            
            
            // 添加点击手势
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.addWebViewTapGesture(tap:)))
            tap.delegate = self
            tap.cancelsTouchesInView = false
            tap.delaysTouchesBegan = true
            webView.addGestureRecognizer(tap)
        }

    }
    
    @objc private func addWebViewTapGesture(tap: UITapGestureRecognizer) {
        
    }
    
    // MARK: - Event response
    func webViewTapAction() {
        
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
        webViewHeight = CGFloat(((webView.stringByEvaluatingJavaScript(from: "document.body.offsetHeight") ?? "0") as NSString).floatValue + 10.0)
        self.setNeedsLayout()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension DiscuListDetailWebCellNode: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
