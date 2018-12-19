//
//  DiscuListViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import YYWebImage

// MARK: - 论坛列表
class DiscuListViewController: ASViewController<ASDisplayNode> {
    
    var fid = ""
    
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
        let headerView = DiscuListHeaderView.loadNib()
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 120)
        headerView.imageView.yy_imageURL = URL.init(string: discuListVM.forum.icon)
        headerView.titleLabel.text = discuListVM.forum.name
        headerView.descLabel.text = "今日\(discuListVM.forum.todayposts)   主题 \(discuListVM.forum.posts)"
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
        
        discuListVM.pageIndex = 1
        let request = DiscuListRequest.init(page: 1, fid: fid)
        discuListVM.list(r: request, successBlock: { [weak self] (hasMore) in
            guard let `self` = self else {return}
            self.addHeaderView()
            self.hasMore = hasMore
        }) {
            
        }
    }
    
    func requestMoreData(finishBlock: @escaping () -> ()) {
        discuListVM.pageIndex += 1
        let request = DiscuListRequest.init(page: discuListVM.pageIndex, fid: fid)
        discuListVM.list(r: request, successBlock: { [weak self] (hasMore) in
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
    
    private lazy var discuListVM: DiscuListViewModel = { [weak self] in
        let vm = DiscuListViewModel()
        vm.tableView = self?.tableNode
        return vm
    }()

    var hasMore: Bool = false
    
}

// MARK: - ASTableDataSource
extension DiscuListViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 置顶帖
             return discuListVM.topList.count
        } else {
             return discuListVM.threadList.count
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        if indexPath.section == 0 {
            let model = self.discuListVM.topList[indexPath.row]
            let cellBlock = { () -> ASCellNode in
                let cellNode = DiscuListPlaceTopCellNode()
                cellNode.model = model
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
            
            let model = self.discuListVM.threadList[indexPath.row]
            let cellBlock = {() -> ASCellNode in
                let cellNode = HotRecommentCellNode()
                cellNode.formList = model
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
extension DiscuListViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return (self.discuListVM.threadList.count > 0) && hasMore
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
