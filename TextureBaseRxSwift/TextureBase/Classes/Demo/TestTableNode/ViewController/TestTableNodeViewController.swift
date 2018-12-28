//
//  TestTableNodeViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import MJRefresh

class TestTableNodeViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupUI()
        viewBindEvents()
    }

    deinit {
        /*
         * 记得在这里将 delegate、dataSource 设为 nil，否则有可能崩溃
         */
        tableNode.delegate = nil
        tableNode.dataSource = nil
    }
    
    // MARK:  - Private methods
    private func setupUI() {
        self.view.addSubnode(tableNode)
        viewBindEvents()
    }

    private func viewBindEvents() {
        
        self.tableNode.view.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            guard let `self` = self else { return }
            self.tableNode.view.mj_header.endRefreshing()
            self.tableNode.reloadData()

        })
        
        self.tableNode.view.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { [weak self] in
            guard let `self` = self else { return }
            self.tableNode.view.mj_header.endRefreshing()
            self.tableNode.reloadData()
        })

    }
    
    // MARK: - Lazy Load
    private lazy var tableNode: ASTableNode = { [weak self] in
        let tableNode = ASTableNode.init(style: UITableView.Style.plain)
        tableNode.frame = UIScreen.main.bounds
        #warning ("ASTableNode的leadingScreensForBatching减缓卡顿")
        tableNode.leadingScreensForBatching = 1.0
        // tableNode.view.separatorStyle = .none
        // tableNode.view.tableHeaderView
        tableNode.delegate = self
        tableNode.dataSource = self
        return tableNode
    }()
    
    
}

// MARK: - ASTableDataSource
extension TestTableNodeViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    // 自动计算大小
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let minSize = CGSize.init(width: UIScreen.main.bounds.width, height: 20)
        let maxSize = CGSize.init(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
        return ASSizeRange.init(min: minSize, max: maxSize)
    }


    // 将要显示
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {

        guard let indexPath = node.indexPath else {
            return
        }
        /*
         * 一个 Node 中的 UIView 是会被清除、重新生成的吗？ 在滑动到下方的时候， Node 中的所有 UIView 都会被干掉，然后滑回来的时候，会被重新执行 Block 中的代码，然后重新添加到界面上
         */
        if let cellNode = tableNode.nodeForRow(at: indexPath) as? CustomeactivityIndicatorCellNode {
            // 不要这个划回来都被移除掉了
            cellNode.resume()
        }
    }
    
    // 返回cell
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock: ASCellNodeBlock = { () -> ASCellNode in
            let cellNode = ImageCellNode.init(key: "测试为内资")
            if ((tableNode.tn_reloadIndexPaths ?? []).contains(indexPath)) {
                cellNode.neverShowPlaceholders = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    cellNode.neverShowPlaceholders = false
                })
            } else {
                cellNode.neverShowPlaceholders = false
            }
            dispatch_async_safely_main_queue {
                // cellNode.startAnimating()
                // UIImage(named: "iconName") // 需注意SomeNode有时会在子线程初始化，而UIImage(named:)并不是线程安全
            }
            return cellNode
        }
        return cellNodeBlock
    }
    
}

// MARK: - ASTableDelegate
extension TestTableNodeViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - configData
extension TestTableNodeViewController {
    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }

    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        #warning("需要放在主线程")
        // [self.mainTableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        context.completeBatchFetching(true)

    }
}
