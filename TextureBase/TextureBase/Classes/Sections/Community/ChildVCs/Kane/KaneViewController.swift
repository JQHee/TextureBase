//
//  KaneViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/17.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 凯恩之角
class KaneViewController: ASViewController<ASDisplayNode> {

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
    }
    
    // MARK: - Private methods
    private func setupUI() {
        node.addSubnode(collectionNode)
        collectionNode.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - Lazy load
    private lazy var collectionNode: ASCollectionNode = { [weak self] in
        #warning("UICollectionViewFlowLayout")
        let layout = UICollectionViewFlowLayout()
        let clv = ASCollectionNode.init(collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        clv.alwaysBounceVertical = true
        // 使用section
        clv.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
        return clv
    }()

}

// MARK: - ASCollectionDataSource
extension KaneViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 10
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // row 高度
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        // (node.bounds.width - 1) / 2.0 就会自动居中
        let minAndMaxSize = CGSize.init(width: (node.bounds.width - 1) / 2.0, height: 70)
        return ASSizeRange.init(min: minAndMaxSize, max: minAndMaxSize)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellBlock = { () -> ASCellNode in
            let cellNode = KaneCellNode()
            cellNode.backgroundColor = UIColor.white
            return cellNode
        }
        return cellBlock
    }
    
    // header
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        if kind == UICollectionView.elementKindSectionHeader {
            let cellNode = KaneSectionCellNode()
            cellNode.style.preferredSize = CGSize.init(width: node.bounds.width, height: 30)
            return cellNode
        }
        return ASCellNode()
    }
}

// MARK: - ASCollectionDelegate
extension KaneViewController: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - ASCollectionLayoutDelegate
extension KaneViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: view.bounds.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
