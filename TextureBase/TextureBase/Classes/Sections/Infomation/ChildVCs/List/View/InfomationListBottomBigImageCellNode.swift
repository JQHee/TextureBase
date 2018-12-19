//
//  InfomationListBottomBigImageCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class InfomationListBottomBigImageCellNode: ASCellNode {
    
    var info: InfomationListInfo! {
        didSet {
            bigImageNode.url = URL.init(string: (info.imgsrc.first ?? "").appropriateImageURLSting())
            let color = UIColor.init(red: 36/255.0, green: 36/255.0, blue: 36/255.0, alpha: 1.0)
            textNode.attributedText = info.title.nodeAttributes(color: color, font: UIFont.init(name: "HelveticaNeue", size: 15) ?? UIFont.systemFont(ofSize: 15))
        }
    }

    override init() {
        super.init()
        addSubnode(textNode)
        addSubnode(bigImageNode)
        
        textNode.placeholderEnabled = true
        textNode.placeholderColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        textNode.isLayerBacked = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        bigImageNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 100)
        
        let stackSepc = ASStackLayoutSpec.vertical()
        stackSepc.spacing = 10
        stackSepc.children = [textNode, bigImageNode]
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: stackSepc)
        return insetSpec
    }
    
    // MARK:  - Lazy load
    lazy var textNode = ASTextNode()
    lazy var bigImageNode = BFNetworkImageNode()
}
