//
//  NetworkImageNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//

// ASNetworkImageNode reload时的闪烁

/*
 // 官方给出的修复方式
let node = ASNetworkImageNode()
node.placeholderColor = UIColor.red
node.placeholderFadeDuration = 3
 
 // 确实没有闪烁了，但这只是将PlaceholderImage--->fetched image图片替换导致的闪烁拉长到3秒而已，自欺欺人，并没有修复。
*/
 

/* 最终的解决方案
 迫不得已之下，当有缓存时，直接用ASImageNode替换ASNetworkImageNode。
 使用时将NetworkImageNode当成ASNetworkImageNode使用即可。
 */

import Foundation
import UIKit
import AsyncDisplayKit


class NetworkImageNode: ASDisplayNode {
    private var networkImageNode = ASNetworkImageNode()
    private var imageNode = ASImageNode()
    
    var placeholderColor: UIColor? {
        didSet {
            networkImageNode.placeholderColor = placeholderColor
        }
    }
    
    var image: UIImage? {
        didSet {
            networkImageNode.image = image
        }
    }
    
    override var placeholderFadeDuration: TimeInterval {
        didSet {
            networkImageNode.placeholderFadeDuration = placeholderFadeDuration
        }
    }
    
    var url: URL? {
        didSet {
            /*
            guard let u = url,
                let image = UIImage.cachedImage(with: u) else {
                    networkImageNode.url = url
                    return
            }
            
            imageNode.image = image
            */
        }
    }
    
    override init() {
        super.init()
        addSubnode(networkImageNode)
        addSubnode(imageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero,
                                 child: networkImageNode.url == nil ? imageNode : networkImageNode)
    }
    
    func addTarget(_ target: Any?, action: Selector, forControlEvents controlEvents: ASControlNodeEvent) {
        networkImageNode.addTarget(target, action: action, forControlEvents: controlEvents)
        imageNode.addTarget(target, action: action, forControlEvents: controlEvents)
    }
}

