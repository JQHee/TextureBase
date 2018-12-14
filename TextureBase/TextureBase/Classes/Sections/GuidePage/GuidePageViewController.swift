//
//  GuidePageViewController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 新特性页面
class GuidePageViewController: ASViewController<ASDisplayNode> {

    // MARK: - Life cycle
    init() {
        super.init(node: ASDisplayNode())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.addSubnode(scrollNode)
        setupContents()
        scrollNode.frame = node.bounds
    }

    // MARK: - Private methods
    private func setupContents() {
        let screen = UIScreen.main.bounds
        for (index, value) in imageNames.enumerated() {
            let imageNode = ASImageNode()
            let path = Bundle.main.path(forResource: value, ofType: "png") ?? ""
            imageNode.image = UIImage.init(contentsOfFile: path)
            let x = CGFloat(index) * screen.width
            imageNode.frame = CGRect.init(x: x, y: 0, width: screen.width, height: screen.height)
            if index == imageNames.count - 1 {
                imageNode.view.isUserInteractionEnabled = true
                imageNode.addSubnode(buttonNode)
            }
            scrollNode.addSubnode(imageNode)
        }
        let contentW = CGFloat(imageNames.count) * screen.width
        scrollNode.view.contentSize = CGSize.init(width: contentW, height: screen.height)
    }

    // MARK: - Event response
    @objc
    func skipButtonAction() {
        UserDefaults.standard.set(true, forKey: "isFirstLoad")
        UserDefaults.standard.synchronize()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.setupRootVC()
    }

    @objc
    func skipButtonNoAction() {

    }

    // MAKR: - Lazy load
    private lazy var scrollNode: ASScrollNode = { [weak self] in
        let scrollNode = ASScrollNode()
        scrollNode.view.showsVerticalScrollIndicator = false
        scrollNode.view.showsHorizontalScrollIndicator = false
        scrollNode.view.delegate = self
        scrollNode.view.isPagingEnabled = true
        // scrollNode.scrollableDirections = .right
        return scrollNode
    }()

    private lazy var buttonNode: ASButtonNode = { [weak self] in
        let buttonNode = ASButtonNode()
        buttonNode.setTitle("立即体验", with: UIFont.systemFont(ofSize: 13), with: UIColor.white, for: UIControl.State.normal)
        let screen = UIScreen.main.bounds
        buttonNode.frame = CGRect.init(x: (screen.width - 120.0) / 2.0, y: screen.height - 100, width: 120, height: 40)
        buttonNode.isHidden = true
        buttonNode.backgroundColor = UIColor.orange
        buttonNode.maskNodeBound(borderWidth: 0, radius: 5, borderColor: UIColor.clear)
        #warning("TouchUpInside")
        /*
         ASControl 中的事件 TouchUpInside 并非与 UIKit 中的事件完全一致
         具体表现为，ASControl中的TouchUpInside不会与Drag手势互斥，当你在拖动ScrollView、TableView的时候，可能会无意中触发到TouchUpInside。
         解决方法：
         再添加一个响应方法去响应 TouchDragInside 就可以了
         */
        buttonNode.addTarget(self, action: #selector(skipButtonAction), forControlEvents: ASControlNodeEvent.touchUpInside)
        buttonNode.addTarget(self, action: #selector(skipButtonNoAction), forControlEvents: ASControlNodeEvent.touchDragInside)
        return buttonNode
    }()

    var imageNames: [String] = ["welecome1", "welecome2", "welecome3", "welecome4"]
}

// MARK: - UIScrollViewDelegate
extension GuidePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        buttonNode.isHidden = (index == imageNames.count - 1) ? false : true
    }
}
