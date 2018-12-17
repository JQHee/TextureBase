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

        #warning("不设置node背景，防止挡住滚动条")
        textNode.placeholderEnabled = true
        textNode.placeholderColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        textNode.isLayerBacked = true
        textNode.maximumNumberOfLines = 1
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
//        let stackSpec = ASStackLayoutSpec.horizontal()
//        stackSpec.alignItems = .center
//        stackSpec.children = [textNode]
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 5, left: 13, bottom: 0, right: 0), child: textNode)
        insetSpec.style.flexShrink = 1
        return insetSpec
    }
    
    // MARK: - Lazy load
    lazy var textNode = ASTextNode()

}
