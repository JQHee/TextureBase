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
    
    var model: KaneDetailList! {
        didSet {
            iconImageNode.url = URL.init(string: model.iconUrl)
            descTextNode.attributedText = model.modelName.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
            titleNode.attributedText = model.modelDesc.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        }
    }
    
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(iconImageNode)
        addSubnode(titleNode)
        addSubnode(descTextNode)
            
        titleNode.maximumNumberOfLines = 1
        descTextNode.maximumNumberOfLines = 1
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        iconImageNode.style.preferredSize = CGSize.init(width: 54, height: 54)
        titleNode.style.flexShrink = 1
        descTextNode.style.flexShrink = 1
        
        // 排列右边的文本
        let rightSpec = ASStackLayoutSpec.vertical()
        rightSpec.alignItems = .stretch
        rightSpec.spacing = 10
        rightSpec.children = [titleNode, descTextNode]
        
        // 左右排列
        let stackSpec = ASStackLayoutSpec.horizontal()
        stackSpec.alignItems = .center
        stackSpec.spacing = 10
        stackSpec.children = [iconImageNode, rightSpec]
        
        // 边距
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 12, bottom: 10, right: 10), child: stackSpec)
        return insetSpec
    }
    
    // MARK: - Lazy load
    lazy var iconImageNode = ASNetworkImageNode()
    lazy var titleNode = ASTextNode()
    lazy var descTextNode = ASTextNode()
}
