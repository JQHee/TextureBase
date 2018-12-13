//
//  TestCollectionNodeVC.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/12.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TestCollectionNodeVC: ASViewController<ASDisplayNode> {

    let threshold:   CGFloat = 0.7
    let itemPerPage: CGFloat = 10
    var currentPage: CGFloat = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubnode(collectionNode)
        
        let label = FPSLabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        self.view.insertSubview(label, at: 999)
    }
    
    // MARK: - Lazy load
    lazy var collectionNode: ASCollectionNode = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width / 3.0, height: 85)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionNode = ASCollectionNode.init(collectionViewLayout: layout)
        collectionNode.frame = UIScreen.main.bounds
        collectionNode.backgroundColor = UIColor.white
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.leadingScreensForBatching = 1.0
        return collectionNode
    }()

}

// MARK: - ASCollectionDataSource
extension TestCollectionNodeVC: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 100000
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellBlock: ASCellNodeBlock = {() -> ASCellNode in
            return TestCollectionNodeCell()
        }
        return cellBlock
    }

}

// MARK: - ASCollectionDelegate
extension TestCollectionNodeVC: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - configData
extension TestCollectionNodeVC {
    // 这个方法返回一个 Bool 值，用于告诉 tableNode 是否需要批抓取
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return true
    }

    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        #warning("需要放在主线程")
        // [self.mainTableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        context.completeBatchFetching(true)
    }

}

// MARK: - 预加载
extension TestCollectionNodeVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.y + scrollView.frame.size.height
        let total = scrollView.contentSize.height
        let ratio = current / total
        
        let needRead = itemPerPage * threshold + currentPage * itemPerPage
        let totalItem = itemPerPage * (currentPage + 1)
        let newThreshold = needRead / totalItem
        
        if ratio >= newThreshold {
            currentPage += 1
            print("Request page \(currentPage) from server.")
        }
    }
}

