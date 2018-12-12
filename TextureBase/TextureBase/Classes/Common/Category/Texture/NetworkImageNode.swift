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
import YYWebImage

class NetworkImageNode: ASDisplayNode {
    
    // 网络图片
    private var networkImageNode = ASNetworkImageNode()
    // 本地图片
    private var imageNode = ASImageNode()
    
    var url: URL? {
        didSet {
            
            guard let u = url,
                let image = cacheImage(key: u.absoluteString) else {
                    networkImageNode.url = url
                    return
            }
            imageNode.image = image
        }
    }
    
    var placeholderColor: UIColor? {
        didSet {
            networkImageNode.placeholderColor = placeholderColor
        }
    }
    
    var defaultImage: UIImage? {
        didSet {
            networkImageNode.defaultImage = defaultImage
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
    
    
    // MARK: - System Methods
    override init() {
        super.init()
        addSubnode(networkImageNode)
        addSubnode(imageNode)
        
        networkImageNode.shouldCacheImage = false
        networkImageNode.delegate = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        guard let tempURL = url else {
            return ASInsetLayoutSpec(insets: .zero,
                              child: networkImageNode)
        }
        return ASInsetLayoutSpec(insets: .zero,
                                 child: haveCacheImage(key: tempURL.absoluteString) ? imageNode : networkImageNode)
    }
    
    // MARK: - Public methods
    // 点击事件
    func addTarget(_ target: Any?, action: Selector, forControlEvents controlEvents: ASControlNodeEvent) {
        networkImageNode.addTarget(target, action: action, forControlEvents: controlEvents)
        imageNode.addTarget(target, action: action, forControlEvents: controlEvents)
    }
}

// MARK: - ASNetworkImageNodeDelegate
extension NetworkImageNode: ASNetworkImageNodeDelegate {
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        if let tempURL = networkImageNode.url {
            YYImageCache.shared().setImage(image, forKey: tempURL.absoluteString)
        }
    }
}

