//
//  TextInsertBlowImageCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/13.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TextInsertBlowImageCellNode: ASCellNode {
    
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(imageNode)
        addSubnode(textNode)
        
        textNode.attributedText = "插入文字".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
        imageNode.image = UIImage.init(named: "textInsertBlowImage.png")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize.init(width: 80, height: 80)
        
        // 插入文本
        let insets = UIEdgeInsets.init(top: 50, left: 12, bottom: 12, right: 12)
        let textInsetSpec = ASInsetLayoutSpec.init(insets: insets, child: textNode)
        
        // 覆盖在图片上面
        let overlayLayoutSpec = ASOverlayLayoutSpec.init(child: imageNode, overlay: textInsetSpec)
        return overlayLayoutSpec
    }
    
    // MARK: - Lazy load
    lazy var textNode = ASTextNode()
    lazy var imageNode = ASImageNode()

}
