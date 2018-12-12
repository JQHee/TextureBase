//
//  CollectionFlowLayout.swift
//  TextureBase
//
//  Created by midland on 2018/12/12.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import Foundation

class CollectionFlowLayout: UICollectionViewFlowLayout {
    var isInsertingToTop = false
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        if !isInsertingToTop {
            return
        }
        let oldSize = collectionView.contentSize
        let newSize = collectionViewContentSize
        let contentOffsetY = collectionView.contentOffset.y + newSize.height - oldSize.height
        collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: contentOffsetY), animated: false)
    }
}

/* insertItems时更改ASCollectionNode的contentOffset引起的闪烁
class MessagesViewController: ASViewController {
    ... // 其他代码
    var collectionNode: ASCollectionNode!
    var flowLayout: CollectionFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = CollectionFlowLayout()
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        ... // 其他代码
    }
    
    ... // 其他代码
    func insertMessagesToTop(indexPathes: [IndexPath]) {
        flowLayout.isInsertingToTop = true
        collectionNode.performBatch(animated: false, updates: {
            self.collectionNode.insertItems(at: indexPaths)
        }) { (finished) in
            self.flowLayout.isInsertingToTop = false
        }
    }
    
    ... // 其他代码
}
 */
