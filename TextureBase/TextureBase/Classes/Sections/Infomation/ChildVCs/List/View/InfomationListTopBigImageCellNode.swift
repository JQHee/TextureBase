//
//  InfomationListTopBigImageCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class InfomationListTopBigImageCellNode: ASCellNode {
    
    var info: InfomationListInfo! {
        didSet {
            iconImageNode.url = URL.init(string: (info.imgsrc.first ?? "").appropriateImageURLSting())
            let color = UIColor.init(red: 36/255.0, green: 36/255.0, blue: 36/255.0, alpha: 1.0)
            titleTextNode.attributedText = info.title.nodeAttributes(color: color, font: UIFont.init(name: "HelveticaNeue", size: 15) ?? UIFont.systemFont(ofSize: 15))
            let replayColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
            replayCountTextNode.attributedText = String(info.replyCount).nodeAttributes(color: replayColor, font: UIFont.init(name: "HelveticaNeue", size: 11) ?? UIFont.systemFont(ofSize: 11))
            timeTextNode.attributedText = info.ptime.nodeAttributes(color: replayColor, font: UIFont.init(name: "HelveticaNeue", size: 11) ?? UIFont.systemFont(ofSize: 11))
        }
    }
    
    override init() {
        super.init()
        addSubnode(iconImageNode)
        addSubnode(titleTextNode)
        addSubnode(timeTextNode)
        addSubnode(replayIconImageNode)
        addSubnode(replayCountTextNode)
        
        titleTextNode.maximumNumberOfLines = 2
        titleTextNode.placeholderEnabled = true
        titleTextNode.placeholderColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        titleTextNode.isLayerBacked = true
        
        replayIconImageNode.image = UIImage.init(named: "common_chat_new")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        replayIconImageNode.style.preferredSize = CGSize.init(width: 12, height: 12)
        iconImageNode.style.preferredSize = CGSize.init(width: constrainedSize.max.width, height: 100)
        
        // 评论数排序
        let rightBottomSpec = ASStackLayoutSpec.horizontal()
        rightBottomSpec.children = [replayIconImageNode, replayCountTextNode]
        rightBottomSpec.spacing = 5
        
        // 时间和评论数
        let bottomSpec = ASStackLayoutSpec.horizontal()
        bottomSpec.children = [timeTextNode, rightBottomSpec]
        bottomSpec.justifyContent = .spaceBetween
        
        // 标题和顶部
        let titleAndBottomSpec = ASStackLayoutSpec.vertical()
        titleAndBottomSpec.children = [titleTextNode, bottomSpec]
        titleAndBottomSpec.spacing = 10
        
        let titleAndBottomInsetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: titleAndBottomSpec)
        
        // 图片和底部内容上下排序
        let contentSpec = ASStackLayoutSpec.vertical()
        contentSpec.children = [iconImageNode, titleAndBottomInsetSpec]
        
        return contentSpec
    }
    
    // MARK: - Lazy load
    lazy var iconImageNode = BFNetworkImageNode()
    lazy var titleTextNode = ASTextNode()
    
    lazy var timeTextNode = ASTextNode()
    lazy var replayIconImageNode = ASImageNode()
    lazy var replayCountTextNode = ASTextNode()

}
