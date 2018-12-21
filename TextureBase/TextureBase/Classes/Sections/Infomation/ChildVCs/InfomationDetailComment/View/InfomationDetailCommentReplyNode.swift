//
//  InfomationDetailCommentCollectionNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/21.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - 回复
class InfomationDetailCommentReplyNode: ASCellNode {
    
    convenience init(itemsName: [String]) {
        self.init()
        self.itemNames = itemsName
    }
    
    override init() {
        super.init()
        setupUI()
    }
    
    override func didLoad() {
        super.didLoad()
        self.maskNodeBound(borderWidth: 1, radius: 3, borderColor: UIColor.red)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let contentSpec = ASStackLayoutSpec.vertical()
        contentSpec.children = items
        return contentSpec
    }
    
    // MARK: - Private methods
    private func setupUI() {
        
        for (_, value) in itemNames.enumerated() {
            let node = InfomationDetailCommentReplyItemNode()
            node.name = value
            items.append(node)
            addSubnode(node)
        }
    }
    
    // MARK: - Lazy load
    lazy var itemNames = ["1", "2", "3", "4", "5"]
    
    var items = [InfomationDetailCommentReplyItemNode]()

}
