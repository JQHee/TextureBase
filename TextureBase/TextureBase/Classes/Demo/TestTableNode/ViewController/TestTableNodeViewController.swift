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
        setupUI()
        viewBindEvents()
    }
    
    // MARK:  - Private methods
    private func setupUI() {
        self.view.addSubnode(tableNode)
    }
    
    private func viewBindEvents() {
        
        self.tableNode.view.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            guard let `self` = self else { return }
            self.tableNode.view.mj_header.endRefreshing()
        })
        
        self.tableNode.view.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { [weak self] in
            guard let `self` = self else { return }
            self.tableNode.view.mj_footer.endRefreshing()
        })

    }
    
    // MARK: - Lazy Load
    private lazy var tableNode: ASTableNode = { [weak self] in
        let tableNode = ASTableNode.init(style: UITableView.Style.plain)
        tableNode.frame = UIScreen.main.bounds
        tableNode.leadingScreensForBatching = 1.0
        tableNode.view.separatorStyle = .none
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
        return 10
    }
    
    // 返回cell
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock: ASCellNodeBlock = { () -> ASCellNode in
            #warning("需要自定义cell")
            return ASCellNode()
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
        // [self.mainTableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        context.completeBatchFetching(true)
    }
}
