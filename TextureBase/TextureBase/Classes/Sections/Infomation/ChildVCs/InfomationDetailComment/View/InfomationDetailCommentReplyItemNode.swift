//
//  InfomationDetailCommentReplyItemNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/21.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 回复子item
class InfomationDetailCommentReplyItemNode: ASCellNode {
    
    var name: String = "" {
        didSet {
            textNode.attributedText = name.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 15))
        }
    }
    
    override init() {
        super.init()
        setupUI()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        lineDispalyNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 1.0)
        
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: textNode)
        
        let contentSpec = ASStackLayoutSpec.vertical()
        contentSpec.children = [insetSpec, lineDispalyNode]
        
        return contentSpec
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(textNode)
        addSubnode(lineDispalyNode)
        
        lineDispalyNode.backgroundColor = UIColor.gray
    }

    // MARK: - Lazy load
    lazy var textNode = ASTextNode()
    // 分割线
    lazy var lineDispalyNode = ASDisplayNode()
}
