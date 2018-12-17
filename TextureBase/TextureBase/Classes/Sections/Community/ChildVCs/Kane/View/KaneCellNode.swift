//
//  KaneCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/17.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

class KaneCellNode: ASCellNode {
    
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(textNode)
        textNode.attributedText = "测试".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stackSpec = ASStackLayoutSpec.vertical()
        stackSpec.alignItems = .center
        stackSpec.justifyContent = .center
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), child: stackSpec)
        return stackSpec
    }
    
    // MARK: - Lazy load
    lazy var textNode = ASTextNode()
}
