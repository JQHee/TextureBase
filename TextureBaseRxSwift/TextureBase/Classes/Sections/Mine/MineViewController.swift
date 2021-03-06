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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
        tableNode.view.parallaxHeader.height = 150
        tableNode.view.parallaxHeader.mode = .fill
        tableNode.view.parallaxHeader.contentView.layer.zPosition = 1
    }

    // MARK: - Lazy load
    lazy var tableNode: ASTableNode = {
        let tableNode = ASTableNode.init(style: .plain)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.tableFooterView = UIView()
        // tableNode.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        return tableNode
    }()

    lazy var mineHeaderView: MineHeaderView = MineHeaderView.loadNib()

    var datas: [(sectionName: String, items: [[String: String]])] = [
        ("Prize", [["name": "无"]]),
        ("SectionName", [["name": "消息"], ["name": "任务"], ["name": "收藏"],  ["name": "收藏"]]),
        ("SectionName", [["name": "设置"], ["name": "意见反馈"]])
    ]

}

// MAKR: - ASTableDelegate
extension MineViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ASTableDataSource
extension MineViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return datas.count
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return datas[section].items.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionView = UIView()
        headerSectionView.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        return headerSectionView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if datas[section].sectionName == "Prize" {
            return 0
        }
        return 10
    }

    // 自动计算大小
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let minSize = CGSize.init(width: UIScreen.main.bounds.width, height: 44)
        let maxSize = CGSize.init(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
        return ASSizeRange.init(min: minSize, max: maxSize)
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let text = self.datas[indexPath.section].items[indexPath.row]["name"] ?? ""
        if datas[indexPath.section].sectionName == "Prize" {
            let cellBlock = { () -> ASCellNode in
                let cellNode = MineItemCellNode()
                return cellNode
            }

            return cellBlock
        } else {
            let cellBlock = { () -> ASCellNode in
                let cellNode = MineCellNode()
                cellNode.text = text
                return cellNode
            }

            return cellBlock
        }
    }
}
