//
//  SelectItemCellNode.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SelectItemCellNode: ASCellNode {
    
    var item: AWSelectListInfo? {
        didSet {
            nameTextNode.attributedText = item?.topicName.nodeAttributes(color: UIColor.black, font: UIFont.systemFont(ofSize: 13), alignment: .center)
            imageCellNode.url = URL.init(string: (item?.iconUrl ?? "").appropriateImageURLSting())
        }
    }

    override init() {
        super.init()
        setupUI ()
    }

    // MARK: - Private methods
    private func setupUI () {
        addSubnode(imageCellNode)
        addSubnode(nameTextNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        imageCellNode.style.preferredSize = CGSize.init(width: 78, height: 78)

        let stackSpec = ASStackLayoutSpec.vertical()
        stackSpec.children = [imageCellNode, nameTextNode]
        stackSpec.alignItems = .center
        stackSpec.spacing = 8
        stackSpec.justifyContent = .start
        return stackSpec
    }

    // MARK: - Lazy load
    lazy var imageCellNode = BFNetworkImageNode()
    lazy var nameTextNode = ASTextNode()
}
