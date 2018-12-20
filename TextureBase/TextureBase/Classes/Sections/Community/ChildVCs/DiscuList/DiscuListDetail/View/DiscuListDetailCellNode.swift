//
//  DiscuListDetailCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import TYAttributedLabel

class DiscuListDetailCellNode: ASCellNode {

    private var list: DiscuListDetailPostlist = DiscuListDetailPostlist.init(json: JSON.null)

    func setList(list: DiscuListDetailPostlist, index: Int) {
        self.list = list
        self.iconImageNode.url = URL.init(string: "http://uc.bbs.d.163.com/images/noavatar_middle.gif")
        self.nameNode.attributedText = list.author.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        self.timeNode.attributedText = list.dateline.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        self.countTextNode.attributedText = "\(index)".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))

        #warning("文本内容需要处理")
        dispatch_async_safely_main_queue {
            (self.contentTextNode.view as? TYAttributedLabel)?.textContainer = list.textContainer
        }
    }

    override init() {
        super.init()
        setupUI()
    }

    override func didLoad() {
        super.didLoad()

    }

    override func layout() {
        super.layout()
        // self.contentTextNode.view.backgroundColor = UIColor.orange
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        iconImageNode.style.preferredSize = CGSize.init(width: 50, height: 50)
        contentTextNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width - 20, height: list.textContainer.textHeight)
        

        let nameSpec = ASStackLayoutSpec.horizontal()
        nameSpec.children = [nameNode, timeNode]
        nameSpec.spacing = 5

        let hSpec = ASStackLayoutSpec.horizontal()
        hSpec.justifyContent = .spaceBetween
        hSpec.children = [nameSpec, countTextNode]
        hSpec.alignItems = .end
        hSpec.style.flexGrow = 1

        let contentHSpec = ASStackLayoutSpec.horizontal()
        contentHSpec.children = [iconImageNode, hSpec]
        contentHSpec.spacing = 10

        let cHSpec = ASStackLayoutSpec.vertical()
        cHSpec.children = [contentHSpec, contentTextNode]
        cHSpec.spacing = 10

        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: cHSpec)
        return insetSpec
    }

    // MARK: - Private methods
    private func setupUI() {
        addSubnode(iconImageNode)
        addSubnode(nameNode)
        addSubnode(timeNode)
        addSubnode(countTextNode)
        addSubnode(contentTextNode)
    }

    // MARK: - Lazy load
    lazy var iconImageNode = BFNetworkImageNode()
    lazy var nameNode = ASTextNode()
    lazy var timeNode = ASTextNode()
    lazy var countTextNode = ASTextNode()
    lazy var contentTextNode: ASDisplayNode = {
        let view = ASDisplayNode.init(viewBlock: { () -> UIView in
            let label = TYAttributedLabel()
            return label
        })
        return view
    }()
}
