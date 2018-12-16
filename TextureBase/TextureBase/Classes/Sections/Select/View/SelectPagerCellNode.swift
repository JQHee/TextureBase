//
//  SelectSectionCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SelectPagerCellNode: ASCellNode {

    var imageInfos: [AWSelectInfo] = [AWSelectInfo] () {
        didSet {
            dispatch_sync_safely_main_queue {
                pagerNode.reloadData()
            }
        }
    }

    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        setupUI()
    }

    override func didLoad() {
        super.didLoad()
        #warning ("要放在主线程中")
        pagerNode.view.isPagingEnabled = false
        pagerNode.view.allowsSelection = true
        pagerNode.reloadData()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insertSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.zero, child: pagerNode)
        return insertSpec
    }

    // MARK: - Private methods
    private func setupUI() {
        addSubnode(pagerNode)
    }

    // MARK: - Lazy load
    #warning ("ASPagerNode的使用")
    lazy var pagerNode: ASPagerNode = {
        let flowLayout = ASPagerFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let pagerNode = ASPagerNode.init(collectionViewLayout: flowLayout)
        pagerNode.dataSource = self
        pagerNode.delegate = self
        return pagerNode
    }()
}

// MARK: - ASPagerDataSource
extension SelectPagerCellNode: ASPagerDataSource, ASCollectionDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return imageInfos.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let minAMaxSize = CGSize.init(width: 267, height: 113)
        return ASSizeRange.init(min: minAMaxSize, max: minAMaxSize)
    }

    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let model = imageInfos[index]
        let cellBlock = {()-> ASCellNode in
            let cellNode = SelectSectionItemCellNode()
            cellNode.item = model
            return cellNode
        }
        return cellBlock
    }

}

// MARK: - ASPagerDelegate
extension SelectPagerCellNode: ASPagerDelegate, UICollectionViewDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {

    }
}
