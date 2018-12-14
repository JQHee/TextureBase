//
//  MineViewController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import MXParallaxHeader

// MARK: - 我的
class MineViewController: ASViewController<ASDisplayNode> {

    // MARK: - Life cycle
    init() {
        super.init(node: ASDisplayNode())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        node.addSubnode(tableNode)
        tableNode.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        tableNode.view.parallaxHeader.view = mineHeaderView
        tableNode.view.parallaxHeader.height = 135
        tableNode.view.parallaxHeader.mode = .fill
        tableNode.view.parallaxHeader.contentView.layer.zPosition = 1
    }

    // MARK: - Lazy load
    lazy var tableNode: ASTableNode = {
        let tableNode = ASTableNode.init(style: .plain)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.tableFooterView = UIView()
        return tableNode
    }()

    lazy var mineHeaderView: MineHeaderView = MineHeaderView.loadNib()

}

// MAKR: - ASTableDelegate
extension MineViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ASTableDataSource
extension MineViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // 自动计算大小
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let minSize = CGSize.init(width: UIScreen.main.bounds.width, height: 44)
        let maxSize = CGSize.init(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
        return ASSizeRange.init(min: minSize, max: maxSize)
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {

        let cellBlock = { () -> ASCellNode in
            let cellNode = MineItemCellNode()
            return cellNode
        }

        return cellBlock
    }
}
