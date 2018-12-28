//
//  DiscuListPlaceTopCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DiscuListPlaceTopCellNode: ASCellNode {
    // 置顶贴
    
    var model: DiscuListForum_threadlist! {
        didSet {
            let titleColor = UIColor.init(red: 36/255.0, green: 36/255.0, blue: 36/255.0, alpha: 1.0)
            textNode.attributedText = model.subject.nodeAttributes(color: titleColor, font: UIFont.init(name: "HelveticaNeue", size: 15) ?? UIFont.systemFont(ofSize: 15))
        }
    }
    
    override init() {
        super.init()
        setupUI()
    }
    
    override func didLoad() {
        super.didLoad()
        topButton.layer.borderWidth = 1
        topButton.layer.borderColor = UIColor.init(red: 236.0/255.0, green: 126.0/255.0, blue: 150.0/255.0, alpha: 1.0).cgColor
        
        textNode.maximumNumberOfLines = 2
        textNode.placeholderEnabled = true
        textNode.placeholderColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        textNode.isLayerBacked = true
    }
    
    // MARK:  - Private methods
    private func setupUI() {
        addSubnode(topButton)
        addSubnode(textNode)
        
        topButton.cornerRadius = 4
        topButton.clipsToBounds = true
        topButton.isUserInteractionEnabled = false
        topButton.setTitle("顶置贴", with: UIFont.systemFont(ofSize: 12), with: UIColor.init(red: 236.0/255.0, green: 126.0/255.0, blue: 150.0/255.0, alpha: 1.0), for: UIControl.State.normal)
        
        textNode.placeholderEnabled = true
        textNode.placeholderColor = UIColor.init(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        textNode.isLayerBacked = true
        textNode.maximumNumberOfLines = 1
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        topButton.style.preferredSize = CGSize.init(width: 43, height: 22)
        
        textNode.style.flexShrink = 1
        
        let contentSpec = ASStackLayoutSpec.horizontal()
        contentSpec.alignItems = .center
        contentSpec.children = [topButton, textNode]
        contentSpec.spacing = 10
        
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: contentSpec)
        return insetSpec
    }
    

    // MARK: - Lazy load
    lazy var topButton = ASButtonNode()
    lazy var textNode = ASTextNode()

}
