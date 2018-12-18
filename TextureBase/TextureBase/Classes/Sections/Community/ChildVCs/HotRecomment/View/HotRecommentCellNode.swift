//
//  HotRecommentCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/18.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HotRecommentCellNode: ASCellNode {
    
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(titleTextNode)
        addSubnode(replayTextNode)
        addSubnode(nameTextNode)
        addSubnode(sendTextNode)
        
        replayTextNode.maximumNumberOfLines = 1
        nameTextNode.maximumNumberOfLines = 1
        sendTextNode.maximumNumberOfLines = 1
        
        titleTextNode.attributedText = "标题".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
        replayTextNode.attributedText = "1".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
        nameTextNode.attributedText = "2".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
        sendTextNode.attributedText = "3".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let bottomStackSpec = ASStackLayoutSpec.horizontal()
        bottomStackSpec.alignItems = .start
        bottomStackSpec.spacing = 15
        bottomStackSpec.children = [replayTextNode, nameTextNode, sendTextNode]
        
        let contentStackSpec = ASStackLayoutSpec.vertical()
        contentStackSpec.spacing = 20
        contentStackSpec.children = [titleTextNode, bottomStackSpec]
        
        let insetSepc = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentStackSpec)
        
        return insetSepc
    }
    
    // MARK: - Lazy load
    lazy var titleTextNode = ASTextNode()
    lazy var replayTextNode = ASTextNode()
    lazy var nameTextNode = ASTextNode()
    lazy var sendTextNode = ASTextNode()

}
