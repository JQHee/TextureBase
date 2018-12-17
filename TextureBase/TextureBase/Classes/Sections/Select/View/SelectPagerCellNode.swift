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
            dispatch_async_safely_main_queue {
                self.pagerNode.reloadData()
            }
        }
    }
    
    var selectFinishBlock: ((_ model: AWSelectInfo) -> ())?

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
    #warning ("ASPagerNode有些代理方法不走，不推荐使用")
    lazy var pagerNode: ASCollectionNode = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let pagerNode = ASCollectionNode.init(collectionViewLayout: flowLayout)
        pagerNode.delegate = self
        pagerNode.dataSource = self
        return pagerNode
    }()
}

// MARK: - ASPagerDataSource
extension SelectPagerCellNode: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return imageInfos.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let minAMaxSize = CGSize.init(width: 267.0, height: 113.0)
        return ASSizeRange.init(min: minAMaxSize, max: minAMaxSize)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = imageInfos[indexPath.row]
        let cellBlock = {() -> ASCellNode in
            let cellNode = SelectSectionItemCellNode()
            cellNode.item = model
            return cellNode
        }
        return cellBlock
    }

}

// MARK: - ASPagerDelegate
extension SelectPagerCellNode: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if let _ = selectFinishBlock {
            let model = imageInfos[indexPath.row]
            selectFinishBlock!(model)
        }

    }
}
