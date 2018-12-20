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
import YYWebImage


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

        hotRecommentVM.pageIndex = 1
        let request = HotRecommentRequest.init(pageIndex: 1, pageSize: 20)
        hotRecommentVM.list(r: request, successBlock: { [weak self] (hasMore) in
            guard let `self` = self else {return}
            self.addBannerView()
            self.hasMore = hasMore
        }) {

        }
    }

    func requestMoreData(finishBlock: @escaping () -> ()) {
        hotRecommentVM.pageIndex += 1
        let request = HotRecommentRequest.init(pageIndex: hotRecommentVM.pageIndex, pageSize: 20)
        hotRecommentVM.list(r: request, successBlock: { [weak self] (hasMore) in
            guard let `self` = self else {return}
            self.hasMore = hasMore
            finishBlock()
        }) {
            finishBlock()
        }
    }
    
    // 添加轮播广告视图
    private func addBannerView() {
        let cycleScrollView = TYCyclePagerView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 105))
        cycleScrollView.delegate = self
        cycleScrollView.dataSource = self
        cycleScrollView.register(BannerViewCell.self, forCellWithReuseIdentifier: kBannerCellID)
        let pageControl = TYPageControl.init(frame: CGRect.init(x: 0, y: cycleScrollView.bounds.height - 26, width: cycleScrollView.bounds.width, height: 26))
        self.pageControl = pageControl
        cycleScrollView.addSubview(pageControl)
        tableNode.view.tableHeaderView = cycleScrollView
        pageControl.numberOfPages = self.hotRecommentVM.focusList.count
        #warning("如果不reload布局会出现不正常")
        cycleScrollView.reloadData()
    }
    
    // MARK:  - Lazy load
    private lazy var tableNode: ASTableNode = { [weak self] in
        let table = ASTableNode.init(style: UITableView.Style.plain)
        table.delegate = self
        table.dataSource = self
        table.leadingScreensForBatching = 1.0
        let nib = UINib.init(nibName: "HotRecommentSectionView", bundle: nil)
        table.view.register( nib, forHeaderFooterViewReuseIdentifier: "HotRecommentSectionView")
        table.view.tableFooterView = UIView()
        return table
    }()

    private lazy var hotRecommentVM: HotRecommentViewModel = { [weak self] in
        let vm = HotRecommentViewModel()
        vm.tableView = self?.tableNode
        return vm
    }()

    var pageControl: TYPageControl?
    var hasMore: Bool = false
    
}

// MARK:  -ASTableDataSource
extension HotRecommentViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return hotRecommentVM.threadList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = hotRecommentVM.threadList[indexPath.row]
        let cellBlock = {() -> ASCellNode in
            let cellNode = HotRecommentCellNode()
            cellNode.selectionStyle = .none
            cellNode.list = model
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "HotRecommentSectionView")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// MARK: - ASTableDelegate
extension HotRecommentViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        // 查询详情
        let model = hotRecommentVM.threadList[indexPath.row]
        let VC = DiscuListDetailViewController()
        VC.tid = model.tid
        self.navigationController?.pushViewController(VC, animated: true)
    }

    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return (self.hotRecommentVM.threadList.count > 0) && hasMore
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

// MARK: - TYCyclePagerViewDelegate
extension HotRecommentViewController: TYCyclePagerViewDelegate {
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        
    }

    func pagerView(_ pageView: TYCyclePagerView, didScrollFrom fromIndex: Int, to toIndex: Int) {
        self.pageControl?.currentPage = toIndex
    }
}

// MARK: - TYCyclePagerViewDataSource
extension HotRecommentViewController: TYCyclePagerViewDataSource {
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return hotRecommentVM.focusList.count
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: kBannerCellID, for: index) as? BannerViewCell else {
            return UICollectionViewCell()
        }
        let model = hotRecommentVM.focusList[index]
        cell.imageView.yy_imageURL = URL.init(string: model.img)
        return cell
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize.init(width: pageView.bounds.width, height: pageView.bounds.height)
        layout.itemSpacing = 10
        return layout
    }
    
    
}

