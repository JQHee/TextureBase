//
//  ImageCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/12.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ImageCellNode: ASCellNode {
    
    private var key: String = ""
    
    convenience init(key: String) {
        self.init()
        self.key = key
        setupUI()
        // titleNode.view.
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize.init(width: 80, height: 60)
        titleNode.style.flexShrink = 1.0
        let spc = ASStackLayoutSpec.init(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [titleNode, imageNode])
        return ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10), child: spc)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(titleNode)
        addSubnode(imageNode)
        
        titleNode.attributedText = key.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 15))
        imageNode.url = URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544594513693&di=75a19b23e965df406f26b9cbccbafad5&imgtype=0&src=http%3A%2F%2Fpic4.zhimg.com%2Fv2-7cc4780a65e481894d1563e3808d2843_r.png")
    }
    
    
    // MAKR: - Lazy Load
    lazy var titleNode: ASTextNode = ASTextNode()
    
    lazy var imageNode: NetworkImageNode = NetworkImageNode()
}
