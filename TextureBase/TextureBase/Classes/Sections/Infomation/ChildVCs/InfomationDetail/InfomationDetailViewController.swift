//
//  InfomationDetailViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 资讯详情
class InfomationDetailViewController: ASViewController<ASDisplayNode> {
    
    var newId = ""
    
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
        let headerView = InfomationDetailHeaderView.loadNib()
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 150)
        headerView.titleLabel.text = self.infomationDetailVM.info.article.title
        headerView.timeLabel.text = self.infomationDetailVM.info.article.ptime
        tableNode.view.tableHeaderView = headerView
    }
    
    func viewBindEvents() {
        tableNode.view.setupRefresh(isNeedFooterRefresh: false, headerCallback: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.requestData()
            }, footerCallBack: {
        })
    }
    
    func requestData() {
        
        let request = InfomationDetailRequest.init(newId: newId)
        infomationDetailVM.list(r: request, successBlock: { [weak self] (hasMore) in
            guard let `self` = self else {return}
            self.addHeaderView()
            UIView.performWithoutAnimation {
                self.tableNode.view.mj_header.endRefreshing()
                self.tableNode.reloadData()
            }
        }) { [weak self] in
            guard let `self` = self else {return}
            UIView.performWithoutAnimation {
                 self.tableNode.view.mj_header.endRefreshing()
                self.tableNode.reloadData()
            }
        }
    }
    
    // MARK:  - Lazy load
    private lazy var tableNode: ASTableNode = {
        let table = ASTableNode.init(style: UITableView.Style.plain)
        table.delegate = self
        table.dataSource = self
        table.view.tableFooterView = UIView()
        let sectionHeaderNib = UINib.init(nibName: "InfomationDetailSectionHeaderView", bundle: nil)
        let sectionFooterNib = UINib.init(nibName: "InfomationDetailSectionFooterView", bundle: nil)
        table.view.register(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: "InfomationDetailSectionHeaderView")
        table.view.register(sectionFooterNib, forHeaderFooterViewReuseIdentifier: "InfomationDetailSectionFooterView")
        return table
    }()
    
    private lazy var infomationDetailVM: InfomationDetailViewModel = {
        let vm = InfomationDetailViewModel()
        return vm
    }()
    
}

// MARK:  -ASTableDataSource
extension InfomationDetailViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return infomationDetailVM.info.article.digest.count > 0 ? 2 : 1
        } else {
            return infomationDetailVM.info.tie.commentIds.count
        }
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        if indexPath.section == 0 {
            var body = infomationDetailVM.info.article.body
            if indexPath.row == 1 {
                body = infomationDetailVM.info.article.digest
            }
            let cellBlock = {() -> ASCellNode in
                let cellNode = InfomationDetailCellNode()
                cellNode.body = body
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
        } else { // 热门跟帖
            #warning("重要的布局")
            let cellBlock = {() -> ASCellNode in
                let cellNode = ASCellNode()
                //cellNode.setList(list: model, index: indexPath.row + 1)
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "InfomationDetailSectionHeaderView")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 && self.infomationDetailVM.info.tie.commentIds.count > 0 {
            return 30
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "InfomationDetailSectionFooterView")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section > 0 && self.infomationDetailVM.info.tie.commentIds.count > 0 {
            return 30
        }
        return 0
    }
}

// MARK: - ASTableDelegate
extension InfomationDetailViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
