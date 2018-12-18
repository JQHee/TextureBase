//
//  HotRecommentViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/17.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import TYCyclePagerView


private let kBannerCellID = "BannerViewCell"

// MARK: - 热门推荐
class HotRecommentViewController: ASViewController<ASDisplayNode> {

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
            self.tableNode.view.mj_header.endRefreshing()
            }, footerCallBack: { [weak self] in
                guard let `self` = self else {
                    return
                }
                self.tableNode.view.mj_footer.endRefreshing()
        })
    }
    
    // 添加轮播广告视图
    private func addBannerView() {
        let cycleScrollView = TYCyclePagerView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 105))
        cycleScrollView.delegate = self
        cycleScrollView.dataSource = self
        cycleScrollView.register(BannerViewCell.classForCoder(), forCellWithReuseIdentifier: kBannerCellID)
        let pageControl = TYPageControl.init(frame: CGRect.init(x: 0, y: cycleScrollView.bounds.height - 26, width: cycleScrollView.bounds.width, height: 26))
        cycleScrollView.addSubview(pageControl)
        tableNode.view.tableHeaderView = cycleScrollView
        // cycleScrollView.reloadData()
    }
    
    // MARK:  - Lazy load
    private lazy var tableNode: ASTableNode = { [weak self] in
        let table = ASTableNode.init(style: UITableView.Style.plain)
        table.delegate = self
        table.dataSource = self
        // table.view.register(, forHeaderFooterViewReuseIdentifier: )
        table.view.tableFooterView = UIView()
        return table
    }()
    
}

// MARK:  -ASTableDataSource
extension HotRecommentViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellBlock = {() -> ASCellNode in
            let cellNode = HotRecommentCellNode()
            return cellNode
        }
        return cellBlock
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HotRecommentSectionView.loadNib()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// MARK: - ASTableDelegate
extension HotRecommentViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - TYCyclePagerViewDelegate
extension HotRecommentViewController: TYCyclePagerViewDelegate {
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        
    }
}

extension HotRecommentViewController: TYCyclePagerViewDataSource {
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return 1
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: kBannerCellID, for: index) as? BannerViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize.init(width: pageView.bounds.width, height: pageView.bounds.height)
        layout.itemSpacing = 10
        return layout
    }
    
    
}

