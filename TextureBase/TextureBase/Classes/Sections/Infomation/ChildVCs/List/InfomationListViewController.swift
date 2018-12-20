//
//  InfomationListViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 首页资讯列表
class InfomationListViewController: ASViewController<ASDisplayNode> {
    
    var topId = ""
    var sourceType = 1
    
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
        
        infomationListVM.pageIndex = 1
        let request = InfomationListRequest.init(topId: topId, pageIndex: 1, pageSize: kPageSize)
        infomationListVM.list(r: request, successBlock: { [weak self] (hasMore) in
            guard let `self` = self else {return}
            self.hasMore = hasMore
        }) {
            
        }
    }
    
    func requestMoreData(finishBlock: @escaping () -> ()) {
        infomationListVM.pageIndex += 1
        let request = InfomationListRequest.init(topId: topId, pageIndex: infomationListVM.pageIndex, pageSize: kPageSize)
        infomationListVM.list(r: request, successBlock: { [weak self] (hasMore) in
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
        // table.view.register(, forHeaderFooterViewReuseIdentifier: )
        table.view.tableFooterView = UIView()
        return table
    }()
    
    private lazy var infomationListVM: InfomationListViewModel = { [weak self] in
        let vm = InfomationListViewModel()
        vm.tableView = self?.tableNode
        return vm
    }()
    
    var hasMore: Bool = false
    
}

// MARK:  -ASTableDataSource
extension InfomationListViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return infomationListVM.info.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = infomationListVM.info[indexPath.row]
        if sourceType == 0 {
            let cellBlock = {() -> ASCellNode in
                let cellNode = InfomationListTopBigImageCellNode()
                cellNode.info = model
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
                switch model.showType {
                case 2:
                    let cellNode = InfomationListBottomBigImageCellNode()
                    cellNode.info = model
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
                    
                default:
                    let cellNode = InfomationListNormalCellNode()
                    cellNode.info = model
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
 
            }
            return cellBlock
        }
    }
}

// MARK: - ASTableDelegate
extension InfomationListViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        let model = infomationListVM.info[indexPath.row]
        let VC = InfomationDetailViewController()
        VC.newId = String(model.newTopicId)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return (self.infomationListVM.info.count > 0) && hasMore
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
