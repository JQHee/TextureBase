//
//  MineCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MineCellNode: ASCellNode {

    override init() {
        super.init()
        self.accessoryType = .disclosureIndicator
        addSubnode(textNode)
        // textNode.attributedText = "测试".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
    }

    var text: String = "" {
        didSet {
            textNode.attributedText = text.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec.horizontal()
        stack.alignItems = .center
        stack.children = [textNode]

        let insertSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 13, bottom: 0, right: 0), child: stack)
        return insertSpec
    }

    // MAKR: - Lazy load
    lazy var textNode = ASTextNode()
}
