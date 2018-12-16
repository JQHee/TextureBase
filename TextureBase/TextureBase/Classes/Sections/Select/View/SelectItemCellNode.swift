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

    override init() {
        super.init()
        setupUI ()
    }

    // MARK: - Private methods
    private func setupUI () {
        addSubnode(imageCellNode)
        addSubnode(nameTextNode)
        nameTextNode.attributedText = "测试".nodeAttributes(color: UIColor.red, font: UIFont.systemFont(ofSize: 13), alignment: .center)
        imageCellNode.url = URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544594513693&di=75a19b23e965df406f26b9cbccbafad5&imgtype=0&src=http%3A%2F%2Fpic4.zhimg.com%2Fv2-7cc4780a65e481894d1563e3808d2843_r.png")
        
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
    lazy var imageCellNode = ASNetworkImageNode()
    lazy var nameTextNode = ASTextNode()
}
