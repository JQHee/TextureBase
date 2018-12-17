//
//  WebBrowserController.swift
//  ZhengHaoFang
//
//  Created by gxcb on 2017/5/25.
//  Copyright © 2017年 Zhenghexing Housing Property Agent Co., Ltd. All rights reserved.
//

import UIKit
import WebKit

// 网页浏览器
class BFWebBrowserController: UITableViewController {

    let progress = UIProgressView(frame: CGRect.zero)
    let webView = WKWebView(frame: CGRect.zero)
    
    var observerAdded = false
    
    var navigationTitle = ""
    var url = ""
    var html = ""
    var headerView = UIView()
    
    fileprivate var isShowingErrorMessage = false
    
    init(urlString: String, navigationBarTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        if navigationBarTitle != nil {
            title = navigationBarTitle!
        }
        url = urlString
    }
    
    init(htmlString: String, navigationBarTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        if navigationBarTitle != nil {
            self.navigationTitle = navigationBarTitle ?? ""
            title = navigationBarTitle!
        }
        html = setGetWebContent(html: htmlString)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        title = navigationTitle
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        
        webView.allowsBackForwardNavigationGestures = true
        
        // 自定义UA
        
        headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64.0))
        tableView.tableHeaderView = headerView
        
        headerView.addSubview(progress)
        headerView.insertSubview(webView, belowSubview: progress)
        
        // 添加webView监听及代理
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        observerAdded = true
        
        // 初始化UIRefreshControl
        let refreshC = UIRefreshControl()
        refreshC.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl = refreshC
        refresh(sender: nil)
    }
    
    // MARK: - Private methods
    private func setupNavBar() {
        let backButton = UIButton(type: .custom)
        let closeButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 40)
        backButton.setImage(#imageLiteral(resourceName: "icon_back"), for: .normal)
        backButton.setImage(#imageLiteral(resourceName: "icon_back"), for: .highlighted)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(buttonBackAction), for: .touchUpInside)
        
        closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        closeButton.setTitle("关闭", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.contentHorizontalAlignment = .left
        closeButton.addTarget(self, action: #selector(buttonCloseAction), for: .touchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)
        let canGobackItem = UIBarButtonItem(customView: closeButton)
        navigationItem.leftBarButtonItems = [backItem, canGobackItem]
    }
    
    // MARK: - Event response
    // canGoback
    @objc
    func buttonBackAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // 关闭
    @objc
    func buttonCloseAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func setGetWebContent(html: String) -> String {

        var content = "<html>"
        content += "<head>"
        content += "<meta charset='utf-8' />"
        content += "<meta name='apple-mobile-web-app-capable' content='yes'>"
        content += "<meta name='apple-mobile-web-app-status-bar-style' content='black'>"
        content += "<meta name='viewport' content='width=device-width,initial-scale=1, minimum-scale=1.0, maximum-scale=1, user-scalable=no'>"
        content += "</head>"
        content += "<body id='content'>"
        content += html
        content += "</body>"
        content += "<script type='text/javascript'>"
        content += "window.onload=function(){"
        content += "var width = document.body.clientWidth;"
        content += "var index = -1;"
        content += "var tempImages = [];"
        content += "var src=document.getElementsByTagName('img');"
        content += "var tempurl='\(API.baseURL)';"
        content += "for (var i=0; i<src.length; i++) {"
        content += "var temURL=tempurl+src[i].getAttribute('src');"
        content += "src[i].setAttribute('src',temURL);"
        content += "tempImages[i] = new Image();"
        content += "tempImages[i].setAttribute('src',src[i].getAttribute('src'));"
        content += "tempImages[i].onload=function() {"
        content += "index++;"
        content += "var imageh = src[index].naturalHeight;"
        content += "var imagew = src[index].naturalWidth;"
        content += "var temph = width * imagew / imagew;"
        content += "if(src[index].naturalWidth > width){"
        content += "src[index].setAttribute('width','100%');"
        content += "src[index].setAttribute('height',temph);"
        content += "src[index].setAttribute('style','margin-top:0px;');}"
        content += "document.body.scrollTop = 0;}}}"
        content += "</script>"
        content += "</html>"
        return content

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        progress.frame = CGRect(origin: headerView.frame.origin, size: CGSize(width: headerView.bounds.width, height: 3.0))
        webView.frame = headerView.bounds
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progress.isHidden = false
            if let font = change?[NSKeyValueChangeKey.newKey] as? Float {
                progress.setProgress(font, animated: false)
                if font >= 1.0 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(250) / Double(NSEC_PER_SEC), execute: {
                        self.progress.isHidden = true
                        self.progress.setProgress(0.0, animated: false)
                    })
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("deinit")
        if observerAdded {
            webView.removeObserver(self, forKeyPath: "estimatedProgress")
        }
    }
    
    @objc func refresh(sender: Any?) {
        if url.count != 0 {
            guard let urlObj = URL(string: url) else {
                show(message: "发生错误")
                return
            }
            webView.load(URLRequest(url: urlObj))
        } else {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}

extension BFWebBrowserController {
    func show(message: String) {
        guard !isShowingErrorMessage else {
            return
        }
        isShowingErrorMessage = true
        
        let messageLabel = UILabel(frame: CGRect(x: 0.0, y: -30.0, width: headerView.bounds.width, height: 30.0))
        headerView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor.white
        messageLabel.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: { 
                        messageLabel.transform = CGAffineTransform(translationX: 0.0, y: messageLabel.bounds.height)
        }) { (finished: Bool) in
            UIView.animate(withDuration: 0.2,
                           delay: 3.5,
                           options: .curveEaseInOut,
                           animations: { 
                            messageLabel.transform = CGAffineTransform.identity
            },
                           completion: { (finished: Bool) in
                            self.isShowingErrorMessage = false
                            messageLabel.removeFromSuperview()
            })
        }
    }
}

extension BFWebBrowserController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlString = navigationAction.request.url
        let scheme = urlString?.scheme
        let app = UIApplication.shared
        // 打电话
        if scheme == "tel" {
            guard let urlString = urlString else { return }
            if app.canOpenURL(urlString) {
                app.openURL(urlString)
                // 一定要加上这句,否则会打开新页面
                decisionHandler(WKNavigationActionPolicy.cancel)
                return
            } 
        }
        decisionHandler(WKNavigationActionPolicy.allow)
        
        if navigationAction.sourceFrame.isMainFrame == true {
            if let urlString = navigationAction.request.url?.absoluteString {
                url = urlString
            }
        }
        
//        if([strRequestisEqualToString:@"about:blank"]) {//主页面加载内容
//            
//            decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
//            
//        } else {//截获页面里面的链接点击
//            
//            //do something you want
//            
//            decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
//            
//        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        refreshControl?.endRefreshing()
        if navigationTitle == "" {
            navigationItem.title = webView.title
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        refreshControl?.endRefreshing()
        if navigationTitle == "" {
            navigationItem.title = webView.title
        }
        
        if (error as NSError).domain == NSURLErrorDomain {
            var errorMessage = ""
            switch (error as NSError).code {
            case NSURLErrorUnknown:
                errorMessage = "发生未知错误"
            case NSURLErrorBadURL:
                errorMessage = "地址错误"
            case NSURLErrorTimedOut:
                errorMessage = "连接超时"
            case NSURLErrorUnsupportedURL:
                errorMessage = "不支持的连接地址"
            case NSURLErrorCannotFindHost:
                errorMessage = "找不到服务器"
            case NSURLErrorCancelled:
                return
            default:
                errorMessage = "加载出错"
            }
            show(message: errorMessage)
        } else {
            show(message: "加载出错")
        }
    }
}
