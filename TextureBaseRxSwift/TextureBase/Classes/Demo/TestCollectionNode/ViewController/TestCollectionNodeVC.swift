//
//  TestCollectionNodeVC.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/12.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TestCollectionNodeVC: ASViewController<ASDisplayNode> {

    let threshold:   CGFloat = 0.7
    let itemPerPage: CGFloat = 10
    var currentPage: CGFloat = 0
    
    var datas = [String]()

    var count: Int = 0
    
    // MARK: - Life cycle
    #warning ("需要初始化该方法才可以使用node添加subnode")
    init() {
        super.init(node: ASDisplayNode())
        node.addSubnode(collectionNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        setupUI()
        viewBindEvents()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)

    }

    func viewBindEvents() {
        collectionNode.view.setupRefresh(isNeedFooterRefresh: false, headerCallback: { [weak self] in
            guard let `self` = self else {
                return

            }
            self.addAction()
        }, footerCallBack: nil)
    }
    
    // MARK: - Event response
    @objc func addAction() {
        if count == 0 {
            count += 1
            for i in 0..<10 {
                self.datas.append("\(i)")
            }
        }

        self.collectionNode.view.mj_header.endRefreshing()

        // collectionNode.cn_reloadIndexPaths = collectionNode.indexPathsForVisibleItems
        collectionNode.reloadData()
    }
    
    // MARK: - Lazy load
    lazy var collectionNode: ASCollectionNode = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width / 3.0, height: 85)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionNode = ASCollectionNode.init(collectionViewLayout: layout)
        collectionNode.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - kStaBarH - kNavBarH)
        collectionNode.backgroundColor = UIColor.white
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.leadingScreensForBatching = 1.0
        // 弹簧属性
        collectionNode.alwaysBounceVertical = true
        return collectionNode
    }()
    
    lazy var button: UIButton = { [weak self] in
        let button = UIButton()
        button.setTitle("添加", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(addAction), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.red, for: UIControl.State.normal)
        return button
    }()

}

// MARK: - ASCollectionDataSource
extension TestCollectionNodeVC: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellBlock: ASCellNodeBlock = {() -> ASCellNode in
            let cellNode = TestCollectionNodeCell()

            if ((collectionNode.cn_reloadIndexPaths ?? []).contains(indexPath)) {
                cellNode.neverShowPlaceholders = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    cellNode.neverShowPlaceholders = false
                })
            } else {
                cellNode.neverShowPlaceholders = false
            }
            return cellNode
        }
        return cellBlock
    }

}

// MARK: - ASCollectionDelegate
extension TestCollectionNodeVC: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - configData
extension TestCollectionNodeVC {
    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取 （添加一个hasNodata标识，滑动时会触发加载）
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return true
    }

    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        #warning("需要放在主线程")
        // [self.mainTableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        context.completeBatchFetching(true)
    }

}

// MARK: - 预加载
extension TestCollectionNodeVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.y + scrollView.frame.size.height
        let total = scrollView.contentSize.height
        let ratio = current / total
        
        let needRead = itemPerPage * threshold + currentPage * itemPerPage
        let totalItem = itemPerPage * (currentPage + 1)
        let newThreshold = needRead / totalItem
        
        if ratio >= newThreshold {
            currentPage += 1
            print("Request page \(currentPage) from server.")
        }
    }
}

