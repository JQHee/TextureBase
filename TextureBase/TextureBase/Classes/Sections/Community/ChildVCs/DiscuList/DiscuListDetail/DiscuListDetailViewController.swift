//
//  DiscuListViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 论坛详情
#warning("待做")
class DiscuListDetailViewController: ASViewController<ASDisplayNode> {

    var tid = ""

    // MARK: - Life cycle
    init() {
        super.init(node: ASDisplayNode())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()
        viewBindEvents()
        requestData()
    }

    deinit {
        self.tableNode.delegate = nil
        self.tableNode.dataSource = nil
    }

    // MARK: - Private methods
    private func setupUI() {
        node.addSubnode(tableNode)
        tableNode.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func addHeaderView() {
        let headerView = DiscuListDetailHeaderView.loadNib()
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 150)
        headerView.titleLabel.text = self.discuListDetailVM.variables.thread.subject
        tableNode.view.tableHeaderView = headerView
    }

    func viewBindEvents() {
        tableNode.view.setupRefresh(isNeedFooterRefresh: false, headerCallback: { [weak self] in
            guard let `self` = self else {
                return

            }
            self.requestData()
            }, footerCallBack: { [weak self] in
                guard let `self` = self else {
                    return
                }
                self.requestMoreData(finishBlock: {})
        })
    }

    func requestData() {

        discuListDetailVM.pageIndex = 1
        let request = DiscuListDetailRequest.init(page: 1, tid: tid)
        discuListDetailVM.list(r: request, successBlock: { [weak self] (hasMore) in
            guard let `self` = self else {return}
            self.addHeaderView()
            self.hasMore = hasMore
        }) {

        }
    }

    func requestMoreData(finishBlock: @escaping () -> ()) {
        discuListDetailVM.pageIndex += 1
        let request = DiscuListDetailRequest.init(page: discuListDetailVM.pageIndex, tid: tid)
        discuListDetailVM.list(r: request, successBlock: { [weak self] (hasMore) in
            guard let `self` = self else {return}
            self.hasMore = hasMore
            finishBlock()
        }) {
            finishBlock()
        }
    }

    // MARK:  - Lazy load
    private lazy var tableNode: ASTableNode = { [weak self] in
        let table = ASTableNode.init(style: UITableView.Style.plain)
        table.delegate = self
        table.dataSource = self
        table.leadingScreensForBatching = 1.0
        table.view.tableFooterView = UIView()
        return table
    }()

    private lazy var discuListDetailVM: DiscuListDetailViewModel = { [weak self] in
        let vm = DiscuListDetailViewModel()
        vm.tableView = self?.tableNode
        return vm
    }()

    var hasMore: Bool = false

}

// MARK:  -ASTableDataSource
extension DiscuListDetailViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return discuListDetailVM.list.count
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let minSize = CGSize.init(width: tableNode.bounds.width, height: 100)
        let maxSize = CGSize.init(width: tableNode.bounds.width, height: 200)
        return ASSizeRange.init(min: minSize, max: maxSize)
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let model = discuListDetailVM.list[indexPath.row]
        if indexPath.row == 0 {
            let cellBlock = {() -> ASCellNode in
                let cellNode = DiscuListDetailWebCellNode()
                cellNode.setList(list: model, index: indexPath.row + 1)
                cellNode.selectionStyle = .none
                if ((tableNode.tn_reloadIndexPaths ?? []).contains(indexPath)) {
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
        } else {
            let cellBlock = {() -> ASCellNode in
                let cellNode = DiscuListDetailCellNode()
                cellNode.setList(list: model, index: indexPath.row + 1)
                cellNode.selectionStyle = .none
                if ((tableNode.tn_reloadIndexPaths ?? []).contains(indexPath)) {
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
}

// MARK: - ASTableDelegate
extension DiscuListDetailViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {

    }

    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return (self.discuListDetailVM.list.count > 0) && hasMore
    }

    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        #warning("需要放在主线程")
        self.requestMoreData(finishBlock: {
            context.completeBatchFetching(true)
        })
        // [self.mainTableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];


    }

}
