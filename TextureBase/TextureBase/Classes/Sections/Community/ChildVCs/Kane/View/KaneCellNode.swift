//
//  KaneCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/17.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class KaneCellNode: ASCellNode {
    
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(iconImageNode)
        addSubnode(titleNode)
        addSubnode(descTextNode)
        
        
        descTextNode.attributedText = "测试".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stackSpec = ASStackLayoutSpec.vertical()
        stackSpec.alignItems = .center
        stackSpec.justifyContent = .center
        stackSpec.children = [descTextNode]
        return stackSpec
    }
    
    // MARK: - Lazy load
    lazy var iconImageNode = ASNetworkImageNode()
    lazy var titleNode = ASTextNode()
    lazy var descTextNode = ASTextNode()
}
