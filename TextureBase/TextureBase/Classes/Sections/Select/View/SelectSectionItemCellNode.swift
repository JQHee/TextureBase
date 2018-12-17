//
//  SelectSectionItemCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SelectSectionItemCellNode: ASCellNode {

    var item: AWSelectInfo? {
        didSet {
            imageNode.url = URL.init(string: item?.imgUrl.appropriateImageURLSting() ?? "")
            textNode.attributedText = (" " + (item?.title ?? "")).nodeAttributes(color: UIColor.white, font: UIFont.systemFont(ofSize: 14))
        }
    }

    override init() {
        super.init()
        setupUI()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        imageNode.style.preferredSize = CGSize.init(width: 267, height: 113)
        textNode.style.flexShrink = 1

        let verStackLayout = ASStackLayoutSpec.vertical()
        verStackLayout.justifyContent = .end
        verStackLayout.alignItems = .stretch
        verStackLayout.children = [textNode]

        let overlayLayout = ASOverlayLayoutSpec.init(child: imageNode, overlay: verStackLayout)
        return overlayLayout
    }

    // MARK: - Private methods
    private func setupUI() {
        addSubnode(imageNode)
        addSubnode(textNode)

        imageNode.contentMode = .scaleAspectFill

        textNode.maximumNumberOfLines = 1
        textNode.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }

    // MARK: - Lazy load
    lazy var imageNode = ASNetworkImageNode()
    lazy var textNode = ASTextNode()
}
