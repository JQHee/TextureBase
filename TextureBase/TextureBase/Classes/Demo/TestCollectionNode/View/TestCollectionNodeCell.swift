//
//  TestCollectionNodeCell.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/12.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TestCollectionNodeCell: ASCellNode {
    
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(imageNode)
        addSubnode(titleNode)
        
        titleNode.maximumNumberOfLines = 1
        titleNode.attributedText = "测试测试测试测试测试测试".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13))
        imageNode.url = URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544594513693&di=75a19b23e965df406f26b9cbccbafad5&imgtype=0&src=http%3A%2F%2Fpic4.zhimg.com%2Fv2-7cc4780a65e481894d1563e3808d2843_r.png")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize.init(width: 80, height: 60)
        let spc = ASStackLayoutSpec.init(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .center, children: [imageNode, titleNode])
        return ASInsetLayoutSpec.init(insets: UIEdgeInsets.zero, child: spc)
    }
    
    // MARK: - Lazy load
    lazy var titleNode: ASTextNode = ASTextNode()
    lazy var imageNode: NetworkImageNode = NetworkImageNode()
    
}
