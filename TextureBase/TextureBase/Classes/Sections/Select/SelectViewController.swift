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

    // MARK:  - Lazy load
    lazy var collectionNode: ASCollectionNode = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        let clv = ASCollectionNode.init(collectionViewLayout: layout)
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .white
        clv.alwaysBounceHorizontal = true
        // 使用section
        clv.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionFooter)
        return clv
    }()

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
            return 20
        default:
            return 0
        }
    }

    // 返回的大小
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        if indexPath.section == 0 {
            let minSize = CGSize.init(width: width, height: 113)
            let maxSize = CGSize.init(width: width, height: 113)
            return ASSizeRangeMake(minSize, maxSize)
        } else {

            let minSize = CGSize.init(width: width / 3.0, height: 102)
            let maxSize = CGSize.init(width: width / 3.0, height: 102)
            return ASSizeRangeMake(minSize, maxSize)
        }
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        if indexPath.section == 0 {
            let cellBlock = { () -> ASCellNode in
                return SelectItemCellNode()
            }
            return cellBlock
        } else {
            let cellBlock = { () -> ASCellNode in
                return SelectItemCellNode()
            }
            return cellBlock
        }
    }
}

// MARK: - ASCollectionDelegate
extension SelectViewController: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {

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
            // return UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            //return 35
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
