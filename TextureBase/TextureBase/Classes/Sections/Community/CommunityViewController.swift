//
//  CommunityViewController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import JXCategoryView

// MARK: - 社区
class CommunityViewController: ASViewController<ASDisplayNode> {

    // MARK: - Life cycle
    init() {
        super.init(node: ASDisplayNode())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #warning("scrollNode.view.bounds 需要在这个方法中才能获取到尺寸")
        // 设置内容contentSize
        let contentSizew = scrollNode.view.bounds.width * CGFloat(titles.count)
        scrollNode.view.contentSize = CGSize.init(width: contentSizew, height: 0)
        guard let tcategoryView = categoryView.view as? JXCategoryTitleView else {
            return
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = tcategoryView.selectedIndex == 0 ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    // MARK: - Private methods
    private func setupUI() {
        node.addSubnode(statusBar)
        node.addSubnode(categoryView)
        node.addSubnode(scrollNode)
        
        guard let tcategoryView = categoryView.view as? JXCategoryTitleView else {
            return
        }
        tcategoryView.titles = self.titles
        tcategoryView.contentScrollView = scrollNode.view
        tcategoryView.delegate = self
    
        statusBar.view.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kStaBarH)
        }
        
        // categoryView.view.frame = CGRect.init(x: 0, y: statusBarH, width: screen.width, height: 44.0)
        
        categoryView.view.snp.makeConstraints { (make) in
            make.top.equalTo(statusBar.view.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(kNavBarH)
        }
        
        scrollNode.view.snp.makeConstraints { (make) in
            make.top.equalTo(categoryView.view.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        // 默认选中第一个
        showVCWithIndex(index: 0)
    }
    
    func showVCWithIndex(index: Int) {

        if !VCsDict.keys.contains(index) { // 不存在 (懒加载)
            if index == 0 {
                let VC = HotRecommentViewController()
                let x = CGFloat(index) * scrollNode.view.bounds.width
                VC.view.frame = CGRect.init(x: x, y: 0, width: scrollNode.view.bounds.width, height: scrollNode.view.bounds.height)
                scrollNode.view.addSubview(VC.view)
                VCsDict[index] = VC
                addChild(VC)
                
            } else if index == 1 {
                let VC = LovePlayCommunityViewController()
                let x = CGFloat(index) * scrollNode.view.bounds.width
                VC.view.frame = CGRect.init(x: x, y: 0, width: scrollNode.view.bounds.width, height: scrollNode.view.bounds.height)
                scrollNode.view.addSubview(VC.view)
                VCsDict[index] = VC
                addChild(VC)
                
            } else { // 凯恩之角
                let VC = KaneViewController()
                let x = CGFloat(index) * scrollNode.view.bounds.width
                VC.view.frame = CGRect.init(x: x, y: 0, width: scrollNode.view.bounds.width, height: scrollNode.view.bounds.height)
                scrollNode.view.addSubview(VC.view)
                VCsDict[index] = VC
                addChild(VC)
                // 加载数据
                // VC.loadFirst()
            }

        }
    }
    
    // MARK: - Lazy load
    lazy var scrollNode: ASScrollNode = {
        let scrollNode = ASScrollNode()
        scrollNode.view.isPagingEnabled = true
        scrollNode.view.showsVerticalScrollIndicator = false
        scrollNode.view.showsHorizontalScrollIndicator = false
        scrollNode.view.bounces = false
        return scrollNode
    }()
    
    
    lazy var categoryView: ASDisplayNode = {
        return ASDisplayNode.init(viewBlock: { () -> UIView in
            let view = JXCategoryTitleView()
            let lineView = JXCategoryIndicatorLineView()
            view.indicators = [lineView]
            view.titleColorGradientEnabled = true
            view.titleColor = UIColor.white
            view.cellSpacing = 10.0
            view.defaultSelectedIndex = 0
            // 居中
            view.averageCellSpacingEnabled = true
            view.backgroundColor = UIColor.black
            return view
        })
    }()
    
    lazy var statusBar: ASDisplayNode = {
        return ASDisplayNode.init(viewBlock: { () -> UIView in
            let view = UIView()
            view.backgroundColor = UIColor.black
            return view
        })
    }()
    
    lazy var titles: [String] = ["热门推荐", "爱玩社区", "凯恩之角"]
    lazy var VCsDict: [Int: UIViewController] = [Int: UIViewController]()

}

// MARK: - JXCategoryViewDelegate
extension CommunityViewController: JXCategoryViewDelegate {
    // 点击或滚动都会调用该方法
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        // 系统默认侧滑返回的手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = index == 0 ? true : false
        showVCWithIndex(index: index)
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        if ratio > 0.5 {
            showVCWithIndex(index: leftIndex)
        } else {
            showVCWithIndex(index: rightIndex)
        }
    }
}
