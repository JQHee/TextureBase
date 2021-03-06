//
//  SelectViewController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 精选
class SelectViewController: ASViewController<ASDisplayNode>  {

    // MARK: - Life cycle
    init() {
        super.init(node: ASDisplayNode())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "精选"
        #warning("tabbar挡住列表内容")
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()
        loadData()
        viewBindEvents()
    }

    deinit {
        self.collectionNode.delegate = nil
        self.collectionNode.dataSource = nil
    }

    // MARK: - Private methods
    private func setupUI() {
        node.addSubnode(collectionNode)
        collectionNode.view.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaInsets)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }

    private func loadData() {
        requestTopData()
        requestListData()
    }

    func viewBindEvents() {
        collectionNode.view.setupRefresh(isNeedFooterRefresh: false, headerCallback: { [weak self] in
            guard let `self` = self else {
                return

            }
            self.loadData()
        }, footerCallBack: nil)
    }


    // 请求列表数据
    private func requestTopData() {
        let request = SelectTopRequest()
        selectVM.loadTopData(r: request, successBlock: { [weak self] in
            guard let `self` = self else {
                return
            }

            self.handleRequestResult(section: 1)
        }) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.handleRequestResult(section: 1)
        }
    }

    // 请求广告数据
    private func requestListData() {
        let request = SelectRequest()
        selectVM.loadListData(r: request, successBlock: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.handleRequestResult(section: 0)

        }) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.handleRequestResult(section: 0)
        }
    }

    private func handleRequestResult(section: Int) {

//        self.collectionNode.performBatchUpdates({
//
//        }) { (finish) in
//
//        }

        if self.collectionNode.view.mj_header.isRefreshing {
            print("123")
            self.collectionNode.view.mj_header.endRefreshing()
        }
        // 不需要自带的刷新动画
        UIView.performWithoutAnimation {
            collectionNode.cn_reloadIndexPaths = collectionNode.indexPathsForVisibleItems
            self.collectionNode.reloadSections(IndexSet.init(integer: section))
        }

        
        // self.collectionNode.reloadData()
    }

    // MARK:  - Lazy load
    lazy var collectionNode: ASCollectionNode = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        let clv = ASCollectionNode.init(collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .white
        clv.alwaysBounceVertical = true
        clv.leadingScreensForBatching = 1.0
        // 使用section
        clv.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionFooter)
        return clv
    }()

    lazy var selectVM = SelectViewModel()

}

// MARK: - ASCollectionDataSource
extension SelectViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 2
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return selectVM.listInfos.count
        default:
            return 0
        }
    }

    // 返回的大小
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        if indexPath.section == 0 {
            let minSize = CGSize.init(width: node.bounds.width, height: 113)
            let maxSize = CGSize.init(width: node.bounds.width, height: 113)
            return ASSizeRangeMake(minSize, maxSize)
            
        } else {
            let minAndMaxSize = CGSize.init(width: (node.bounds.width - 40) / 3.0, height: 102)
            return ASSizeRangeMake(minAndMaxSize, minAndMaxSize)
        }
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        if indexPath.section == 0 {
            let cellBlock = { [weak self]() -> ASCellNode in
                guard let `self` = self else {
                    return SelectPagerCellNode()
                }
                let cellNode = SelectPagerCellNode()
                cellNode.imageInfos = self.selectVM.infos
                cellNode.selectFinishBlock = { (tempModel) in
                    // 查看广告详情
                    let VC = BFWebBrowserController.init(urlString: tempModel.address, navigationBarTitle: tempModel.title)
                    self.navigationController?.pushViewController(VC, animated: true)
                }
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
        } else {
            let model = selectVM.listInfos[indexPath.row]
            let cellBlock = { () -> ASCellNode in
                let cellNode = SelectItemCellNode()
                cellNode.item = model
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
}

// MARK: - ASCollectionDelegate
extension SelectViewController: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            let model = selectVM.listInfos[indexPath.row]
            print(model.id)
            let VC = InfomationListViewController()
            VC.topId = String(model.topicId)
            VC.sourceType = model.sourceType
            VC.title = model.topicName
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
    }

    // footer
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        if indexPath.section == 0 && kind == UICollectionView.elementKindSectionFooter {
            let cellNode = ASCellNode()
            cellNode.backgroundColor = UIColor.init(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
            cellNode.style.preferredSize = CGSize.init(width: view.bounds.width, height: 6.0)
            return cellNode
        }
        return ASCellNode()
    }

}

// MARK: - ASCollectionDelegate
extension SelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: view.bounds.width, height: 6)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets.init(top: 15, left: 0, bottom: 15, right: 0)
        } else if section == 1 {
            return UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 35
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - configData
extension SelectViewController {
    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取 （添加一个hasNodata标识，滑动时会触发加载）
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return false
    }

    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        #warning("需要放在主线程")
        // [self.mainTableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        context.completeBatchFetching(true)
    }

}
