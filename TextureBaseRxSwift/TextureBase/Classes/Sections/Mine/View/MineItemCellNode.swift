//
//  MineItemCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MineItemCellNode: ASCellNode {

    override init() {
        super.init()
        selectionStyle = .none
        addSubnode(leftTextNode)
        addSubnode(leftImageNode)
        addSubnode(leftButtonNode)

        // 分割线
        addSubnode(lineTextNode)

        addSubnode(rightTextNode)
        addSubnode(rightImageNode)
        addSubnode(rightButtonNode)

        lineTextNode.backgroundColor = .gray
        leftButtonNode.backgroundColor = .clear
        rightButtonNode.backgroundColor = .clear

        leftButtonNode.addTarget(self, action: #selector(leftButtonAction), forControlEvents: ASControlNodeEvent.touchUpInside)
        rightButtonNode.addTarget(self, action: #selector(rightButtonAction), forControlEvents: ASControlNodeEvent.touchUpInside)

        leftTextNode.attributedText = "  积分福利".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        leftImageNode.image = UIImage.init(named: "mine_welfare_img")

        rightTextNode.attributedText = "  游戏礼包".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        rightImageNode.image = UIImage.init(named: "mine_gift_img")
    }

    // MARK: - Event response
    @objc
    func leftButtonAction() {
        print("leftButtonNode")
    }

    @objc
    func rightButtonAction() {
        print("rightButtonNode")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        lineTextNode.style.preferredSize = CGSize.init(width: 0.5, height: self.bounds.height)
        leftImageNode.style.preferredSize = CGSize.init(width: 80, height: 60)
        rightImageNode.style.preferredSize = CGSize.init(width: 80, height: 60)

        // 左边内容布局
        let leftStack = ASStackLayoutSpec.horizontal()
        leftStack.alignItems = .center
        leftStack.justifyContent = .spaceBetween
        leftStack.children = [leftTextNode, leftImageNode]
        leftStack.spacing = 5.0
        // 在上面覆盖一个按钮
        let leftOver = ASOverlayLayoutSpec.init(child: leftStack, overlay: leftButtonNode)
        let leftInsertSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), child: leftOver)
        leftInsertSpec.style.flexGrow = 1

        // 右边内容布局
        let rightStack = ASStackLayoutSpec.horizontal()
        rightStack.alignItems = .center
        rightStack.justifyContent = .spaceBetween
        rightStack.children = [rightTextNode, rightImageNode]
        rightStack.spacing = 5.0
        let rightOver = ASOverlayLayoutSpec.init(child: rightStack, overlay: rightButtonNode)
        let rightInsertSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), child: rightOver)
        rightInsertSpec.style.flexGrow = 1

        let stacks = ASStackLayoutSpec.horizontal()
        stacks.spacing = 1.0
        //stacks.justifyContent = .spaceAround
        stacks.children = [leftInsertSpec, lineTextNode ,rightInsertSpec]

        // 添加中间的分割线
        return stacks
    }

    // MAKR: - Lazy load
    // 左边
    lazy var leftTextNode = ASTextNode()
    lazy var leftImageNode = ASImageNode()
    lazy var leftButtonNode = ASButtonNode()

    // 分隔线
    lazy var lineTextNode = ASTextNode()

    // 右边
    lazy var rightTextNode = ASTextNode()
    lazy var rightImageNode = ASImageNode()
    lazy var rightButtonNode = ASButtonNode()

}
