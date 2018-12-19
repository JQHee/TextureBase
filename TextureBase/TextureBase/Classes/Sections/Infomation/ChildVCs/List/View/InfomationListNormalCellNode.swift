//
//  InfomationListNormalCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class InfomationListNormalCellNode: ASCellNode {
    
    var info: InfomationListInfo! {
        didSet {
            iconImageNode.url = URL.init(string: (info.imgsrc.first ?? "").appropriateImageURLSting())
            let color = UIColor.init(red: 36/255.0, green: 36/255.0, blue: 36/255.0, alpha: 1.0)
            titleTextNode.attributedText = info.title.nodeAttributes(color: color, font: UIFont.init(name: "HelveticaNeue", size: 15) ?? UIFont.systemFont(ofSize: 15))
            let replayColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
            replayCountTextNode.attributedText = String(info.replyCount).nodeAttributes(color: replayColor, font: UIFont.init(name: "HelveticaNeue", size: 11) ?? UIFont.systemFont(ofSize: 11))
        }
    }
    
    override init() {
        super.init()
        addSubnode(iconImageNode)
        addSubnode(titleTextNode)
        addSubnode(replayIconImageNode)
        addSubnode(replayCountTextNode)
        
        titleTextNode.maximumNumberOfLines = 2
        titleTextNode.placeholderEnabled = true
        titleTextNode.placeholderColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        titleTextNode.isLayerBacked = true
        
        replayIconImageNode.image = UIImage.init(named: "common_chat_new")
        replayIconImageNode.contentMode = .center
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        replayIconImageNode.style.preferredSize = CGSize.init(width: 11, height: 11)
        iconImageNode.style.preferredSize = CGSize.init(width: 84, height: 62)
        titleTextNode.style.flexShrink = 1
        
        // 评论数排序
        let rightBottomSpec = ASStackLayoutSpec.horizontal()
        rightBottomSpec.children = [replayIconImageNode, replayCountTextNode]
        rightBottomSpec.spacing = 5
        rightBottomSpec.alignItems = .center
        rightBottomSpec.justifyContent = .start
        
        // 右边内容上下排列
        let rightSpec = ASStackLayoutSpec.vertical()
        rightSpec.children = [titleTextNode, rightBottomSpec]
        rightSpec.spacing = 0
        rightSpec.alignItems = .start
        #warning("子元素在主轴上的对齐方式")
        rightSpec.justifyContent = .spaceBetween
        #warning("不设置则titileTextNode不能换行")
        rightSpec.style.flexShrink = 1
        
        // 左右排列
        let contentSpec = ASStackLayoutSpec.horizontal()
        contentSpec.children = [iconImageNode, rightSpec]
        contentSpec.spacing = 10
        contentSpec.alignItems = .stretch
        
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentSpec)
        return insetSpec
    }
    
    // MARK: - Lazy load
    lazy var iconImageNode = BFNetworkImageNode()
    lazy var titleTextNode = ASTextNode()
    lazy var replayIconImageNode = ASImageNode()
    lazy var replayCountTextNode = ASTextNode()

}
