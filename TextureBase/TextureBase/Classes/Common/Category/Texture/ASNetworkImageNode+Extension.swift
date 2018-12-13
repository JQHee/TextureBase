//
//  ASNetworkImageNode+Extension.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/12.
//  Copyright © 2018 ml. All rights reserved.
//

import Foundation
import UIKit
import YYWebImage
import AsyncDisplayKit

extension ASNetworkImageNode {
    static func imageNode() -> ASNetworkImageNode {
        let manager = YYWebImageManager.shared()
        return ASNetworkImageNode(cache: manager, downloader: manager)
    }
}

extension YYWebImageManager: ASImageCacheProtocol, ASImageDownloaderProtocol {

    // 下载图片
    public func downloadImage(with URL: URL,
                              callbackQueue: DispatchQueue,
                              downloadProgress: AsyncDisplayKit.ASImageDownloaderProgress?,
                              completion: @escaping AsyncDisplayKit.ASImageDownloaderCompletion) -> Any? {
        weak var operation: YYWebImageOperation?
        operation = requestImage(with: URL,
                                 options: .setImageWithFadeAnimation,
                                 progress: { (received, expected) -> Void in
                                    callbackQueue.async(execute: {
                                        let progress = expected == 0 ? 0 : received / expected
                                        downloadProgress?(CGFloat(progress))
                                    })
        }, transform: nil, completion: { (image, url, from, state, error) in
            completion(image, error, operation, error)
        })

        return operation
    }

    public func clearFetchedImageFromCache(with URL: URL) {

        let manager = YYWebImageManager.shared()
        if(manager.cache?.containsImage(forKey: URL.absoluteString, with: .memory))! {
            //            print("从内存删除图片")
            manager.cache?.removeImage(forKey: URL.absoluteString, with: .memory)
        }
    }

    // 取消下载
    public func cancelImageDownload(forIdentifier downloadIdentifier: Any) {
        guard let operation = downloadIdentifier as? YYWebImageOperation else {
            return
        }
        operation.cancel()
    }

    // 查看本地缓存
    public func cachedImage(with URL: URL, callbackQueue: DispatchQueue, completion: @escaping AsyncDisplayKit.ASImageCacherCompletion) {
        cache?.getImageForKey(cacheKey(for: URL), with: .all, with: { (image, cacheType) in
            callbackQueue.async {
                completion(image)
            }
        })
    }
}

// 下载图片
class BFNetworkImageNode: ASDisplayNode {
    private var networkImageNode = ASNetworkImageNode.imageNode()
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
            guard let u = url,
                let image = cacheImage(key: u.absoluteString) else {
                    networkImageNode.url = url
                    return
            }

            imageNode.image = image
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
