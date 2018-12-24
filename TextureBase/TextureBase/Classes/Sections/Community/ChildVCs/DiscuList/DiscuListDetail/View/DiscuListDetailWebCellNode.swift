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
            self.loadWebHtml(htmlBody: list.message as NSString)
        }
    }

    var webViewHeight: CGFloat = 0
    var lastWebviewHeight: CGFloat = 0

    override init() {
        super.init()
        setupUI()

    }

//    override func calculateSizeThatFits(_ constrainedSize: CGSize) -> CGSize {
//        return CGSize.init(width: constrainedSize.width, height: webViewHeight == 0 ? 0.001 : webViewHeight)
//    }
    
    deinit {
        
        DispatchQueue.main.async {
            do {
                // (self.webViewNode.view as? UIWebView)?.scrollView.removeObserver(self, forKeyPath: "contentSize")
            }
        }
    }

    override func layout() {
        super.layout()
        // self.webViewNode.view.frame = CGRect.init(x: 10, y: 50, width: kScreenW - 20, height: webViewHeight == 0 ? 0.001 : webViewHeight)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        iconImageNode.style.preferredSize = CGSize.init(width: 50, height: 50)
        webViewNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width - 20, height: webViewHeight == 0 ? 0.001 : webViewHeight)

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
            
            // kvo 监听内容高度
            // webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
            
            // 添加点击手势
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.addWebViewTapGesture(tap:)))
            tap.delegate = self
            tap.cancelsTouchesInView = false
            tap.delaysTouchesBegan = true
            webView.addGestureRecognizer(tap)
        }

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath ?? "") == "contentSize" {
            guard let webView = self.webViewNode.view as? UIWebView else {
                return
            }
            webViewHeight = webView.sizeThatFits(CGSize.zero).height
            if webViewHeight > 0 {
                if webViewHeight != lastWebviewHeight {
                    UIView.performWithoutAnimation {
                        self.setNeedsLayout()
                        self.layoutIfNeeded()
                    }
                }
            }
            lastWebviewHeight = webViewHeight

        }
    }
    
    func loadWebHtml(htmlBody: NSString) {
        let cssURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "News", ofType: "css") ?? "")
        guard let webView = self.webViewNode.view as? UIWebView else {
            return
        }
        webView.loadHTMLString(handleWithHtmlBody(htmlBody: htmlBody), baseURL: cssURL)
        
    }
    
    func handleWithHtmlBody(htmlBody: NSString) -> String {
        let html = htmlBody.replacingOccurrences(of: "\t", with: "")
        let cssName = "News.css"
        var htmlString = "<html>"
        htmlString += "<head><meta charset=\"UTF-8\">"
        htmlString += "<link rel =\"stylesheet\" href = \""
        htmlString += cssName
        htmlString += "\" type=\"text/css\" />"
        htmlString += "</head>"
        htmlString += "<body>"
        htmlString += html
        htmlString += "</body>"
        htmlString += "</html>"
        return html
    }
    
    // 点击图片
    @objc private func addWebViewTapGesture(tap: UITapGestureRecognizer) {
        guard let contentView = tap.view else {
            return
        }
        guard let webView = contentView as? UIWebView else {
            return
        }
        let pt = tap.location(in: webView)
        let imageURL = "document.elementFromPoint(\(pt.x), \(pt.y)).src"
        let urlToSave = webView.stringByEvaluatingJavaScript(from: imageURL)
        if (urlToSave ?? "").count  > 0 {
            print(urlToSave ?? "")
            showImageURL(url: urlToSave ?? "", point: pt)
            
        }
    }
    
    func showImageURL(url: String, point: CGPoint) {
        if !url.hasPrefix("http") { return }
        // 查看图片
        guard let viewController  = self.view.viewContainingController() else {
            return
        }
        BFPhotoViewer.shared.viewRemoteImages(vc: viewController, datas: [url], currentIndex: 0)
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
        webViewHeight = CGFloat(((webView.stringByEvaluatingJavaScript(from: "document.body.offsetHeight") ?? "0.01") as NSString).floatValue + 10.0)
        if webViewHeight > 0  {
            if webViewHeight != lastWebviewHeight {
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }
        lastWebviewHeight = webViewHeight
        #warning("会多次触发，导致重复更新布局，闪烁")
        // self.setNeedsLayout()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension DiscuListDetailWebCellNode: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
