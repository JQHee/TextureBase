//
//  HotRecommentCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/18.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HotRecommentCellNode: ASCellNode {
    
    var list: HotRecommentThreadList! {
        didSet {
            let titleColor = UIColor.init(red: 36/255.0, green: 36/255.0, blue: 36/255.0, alpha: 1.0)
            titleTextNode.attributedText = list.title.nodeAttributes(color: titleColor, font: UIFont.init(name: "HelveticaNeue", size: 15) ?? UIFont.systemFont(ofSize: 15))
            let color = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
            replayTextNode.attributedText = "\(list.replies)回复".nodeAttributes(color: color, font: UIFont.init(name: "HelveticaNeue", size: 11) ?? UIFont.systemFont(ofSize: 11))
            nameTextNode.attributedText = list.author.nodeAttributes(color: color, font: UIFont.init(name: "HelveticaNeue", size: 11) ?? UIFont.systemFont(ofSize: 11))
            
            let attrs = [NSAttributedString.Key.font: UIFont.init(name: "HelveticaNeue", size: 11) ?? UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: color]
            let detailText = "发表于\(list.fname)" as NSString
            let attr = NSMutableAttributedString.init(string: detailText as String, attributes: attrs)
            #warning("detailText 为 NSString")
            let range = detailText.range(of: list.fname)
            attr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(red: 129/255.0, green: 179/255.0, blue: 252/255.0, alpha: 1.0)], range: range)
            sendTextNode.attributedText = attr
        }
    }
    override init() {
        super.init()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubnode(titleTextNode)
        addSubnode(replayTextNode)
        addSubnode(nameTextNode)
        addSubnode(sendTextNode)
        
        titleTextNode.maximumNumberOfLines = 2
        titleTextNode.placeholderEnabled = true
        titleTextNode.placeholderColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        titleTextNode.isLayerBacked = true
        
        replayTextNode.maximumNumberOfLines = 1
        nameTextNode.maximumNumberOfLines = 1
        sendTextNode.maximumNumberOfLines = 1
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let bottomStackSpec = ASStackLayoutSpec.horizontal()
        bottomStackSpec.alignItems = .start
        bottomStackSpec.spacing = 15
        bottomStackSpec.children = [replayTextNode, nameTextNode, sendTextNode]
        
        let contentStackSpec = ASStackLayoutSpec.vertical()
        contentStackSpec.spacing = 20
        contentStackSpec.children = [titleTextNode, bottomStackSpec]
        
        let insetSepc = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentStackSpec)
        
        #warning("自定义分割线")
        //   ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout,_underLineNode]];
        
        return insetSepc
    }
    
    // MARK: - Lazy load
    lazy var titleTextNode = ASTextNode()
    lazy var replayTextNode = ASTextNode()
    lazy var nameTextNode = ASTextNode()
    lazy var sendTextNode = ASTextNode()

}
