//
//  LeftAndRightTitleCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/13.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class LeftAndRightTitleCellNode: ASCellNode {
    
    override init() {
        super.init()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(leftTopTextNode)
        addSubnode(leftBottomTextNode)
        addSubnode(rightCenterTextNode)
        
        leftTopTextNode.maximumNumberOfLines = 1
        leftTopTextNode.attributedText = "左上".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
        
        leftBottomTextNode.maximumNumberOfLines = 1
        leftBottomTextNode.attributedText = "左下".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
        
        rightCenterTextNode.maximumNumberOfLines = 1
        rightCenterTextNode.truncationMode = .byTruncatingTail
        rightCenterTextNode.attributedText = "右中".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // 左边的内容上下排列
        let leftSpec = ASStackLayoutSpec.vertical()
        leftSpec.style.flexGrow = 1.0
        leftSpec.style.flexShrink = 1.0
        leftSpec.children = [leftTopTextNode, leftBottomTextNode]
        
        // 左右布局
        let leftAndRightSpec = ASStackLayoutSpec.horizontal()
        leftAndRightSpec.spacing = 40
        leftAndRightSpec.justifyContent = .start
        leftAndRightSpec.alignItems = .center
        leftAndRightSpec.children = [leftSpec, rightCenterTextNode]
        
        // 设置边距
        let spaceInsertSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5), child: leftAndRightSpec)
        return spaceInsertSpec
        
    }
    
    // MARK: - Lazy load
    lazy var leftTopTextNode = ASTextNode()
    lazy var leftBottomTextNode = ASTextNode()
    lazy var rightCenterTextNode = ASTextNode()

}


