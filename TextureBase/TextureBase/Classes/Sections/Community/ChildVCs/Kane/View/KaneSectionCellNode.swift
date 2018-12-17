//
//  KaneSectionCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/17.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class KaneSectionCellNode: ASCellNode {
    
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(textNode)
        textNode.attributedText = "测试".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stackSpec = ASStackLayoutSpec.horizontal()
        stackSpec.alignItems = .center
        stackSpec.children = [textNode]
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 0), child: stackSpec)
        return insetSpec
    }
    
    // MARK: - Lazy load
    lazy var textNode = ASTextNode()

}
