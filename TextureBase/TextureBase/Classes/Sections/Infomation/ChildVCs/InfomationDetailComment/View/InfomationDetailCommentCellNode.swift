//
//  InfomationDetailCommentCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/21.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 评论
class InfomationDetailCommentCellNode: ASCellNode {

    override init() {
        super.init()
        setupUI()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let contentSpec = ASStackLayoutSpec.vertical()
        contentSpec.children = [textNode, replyNode]
        contentSpec.spacing = 10
        
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentSpec)
        
        return insetSpec
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(textNode)
        addSubnode(replyNode)
        
        // replyNode.isLayerBacked = true
        textNode.attributedText = "测试标题".nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 15))
    }
    
    // MARK: - Lazy load
    lazy var textNode = ASTextNode()
    lazy var replyNode = InfomationDetailCommentReplyNode.init(itemsName: ["1", "2", "3", "4", "5"])
    
}
