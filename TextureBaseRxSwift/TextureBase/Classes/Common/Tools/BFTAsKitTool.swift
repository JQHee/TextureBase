//
//  BFTAsKitTool.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

class BFTAsKitTool: NSObject {
    
    /**
     NodeLabel
     
     @param addNode 待添加的node
     @return nodeLabel
     */
    static func nodeTextNodeAddNode(addNode: ASDisplayNode) -> ASTextNode {
        // 只支持富文本显示
        let textNode = ASTextNode()
        addNode.addSubnode(textNode)
        return textNode
    }
    
    /**
     nodeView
     
     @param addNode 待添加的node
     @param backgroundColor 背景色
     @return nodeView
     */
    static func nodeDisplayNodeAddNode(addNode: ASDisplayNode, backgroundColor: UIColor) -> ASDisplayNode {
        // 只支持富文本显示
        let displayNode = ASDisplayNode()
        displayNode.backgroundColor = backgroundColor
        addNode.addSubnode(displayNode)
        return displayNode
    }
    
    /**
     NodeButton(文本)
     
     @param addNode 添加View
     @param title 标题
     @param titleColor 标题颜色
     @param font 字体
     @param cornerRadius 圆角
     @param backgroundColor 背景颜色
     @param contentVerticalAlignment 内容竖直对齐方式
     @param contentHorizontalAlignment 内容水平对齐方式
     */
    static func nodeButtonNodeAddNode(addNode: ASDisplayNode, title: String?, titleColor: UIColor, font: UIFont, cornerRadius: CGFloat, contentVerticalAlignment: ASVerticalAlignment, contentHorizontalAlignment: ASHorizontalAlignment,  backgroundColor: UIColor) -> ASButtonNode {
        // 只支持富文本显示
        let buttonNode = ASButtonNode()
        buttonNode.backgroundColor = backgroundColor
        if let _ = title {
            buttonNode.setTitle(title!, with: font, with: titleColor, for: UIControl.State.normal)
        }
        buttonNode.contentVerticalAlignment = contentVerticalAlignment
        buttonNode.contentHorizontalAlignment = contentHorizontalAlignment
        buttonNode.cornerRadius = cornerRadius
        addNode.addSubnode(buttonNode)
        return buttonNode
    }
    
    /**
     NodeButton(图文)
     
     @param addNode 添加View
     @param title 标题
     @param titleColor 标题颜色
     @param font 字体
     @param image 图片
     @param imageAlignment 图片对齐方式(前/后)
     @param cornerRadius 圆角
     @param backgroundColor 背景颜色
     @param contentVerticalAlignment 内容竖直对齐方式
     @param contentHorizontalAlignment 内容水平对齐方式
     */
    static func nodeButtonNodeAddNode(addNode: ASDisplayNode, title: String?, titleColor: UIColor, font: UIFont, image: UIImage?, imageAlignment: ASButtonNodeImageAlignment, cornerRadius: CGFloat, contentVerticalAlignment: ASVerticalAlignment, contentHorizontalAlignment: ASHorizontalAlignment,  backgroundColor: UIColor) -> ASButtonNode {
        // 只支持富文本显示
        let buttonNode = ASButtonNode()
        buttonNode.backgroundColor = backgroundColor
        if let _ = title {
            buttonNode.setTitle(title!, with: font, with: titleColor, for: UIControl.State.normal)
        }
        if let _ = image {
            buttonNode.setImage(image, for: UIControl.State.normal)
        }
        buttonNode.imageAlignment = imageAlignment
        buttonNode.contentVerticalAlignment = contentVerticalAlignment
        buttonNode.contentHorizontalAlignment = contentHorizontalAlignment
        buttonNode.cornerRadius = cornerRadius
        addNode.addSubnode(buttonNode)
        return buttonNode
    }
    
    /**
     添加特殊的buttonNode
     
     @param addNode
     @param title
     @param titleColor
     @param font
     @param image
     @return
     */
    static func nodeButtonNodeAddNode(addNode: ASDisplayNode, title: String?, titleColor: UIColor, font: UIFont, image: UIImage?,  backgroundColor: UIColor) -> ASButtonNode {
        let buttonNode = ASButtonNode.init { () -> UIView in
            let button: BFImageTextButton = BFImageTextButton()
            button.imageEdgeInsets = UIEdgeInsets.init(top: 4, left: 0, bottom: 4, right: 0)
            button.setTitle(title, for: UIControl.State.normal)
            button.tintColor = titleColor
            button.titleLabel?.font = font
            button.setImage(image, for: UIControl.State.normal)
            button.imageEdgeInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 0, right: 0)
            return button
        }
        buttonNode.backgroundColor = backgroundColor
        if let _ = title {
            buttonNode.setTitle(title!, with: font, with: titleColor, for: UIControl.State.normal)
        }
        if let _ = image {
            buttonNode.setImage(image, for: UIControl.State.normal)
        }
        buttonNode.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        buttonNode.imageAlignment = .beginning
        buttonNode.contentVerticalAlignment = .center
        buttonNode.contentHorizontalAlignment = .middle
        addNode.addSubnode(buttonNode)
        return buttonNode
    }
    
    /**
     NodeImageView(普通)
     
     @param addNode 添加View
     @param clipsToBounds 边界裁剪
     @param contentMode 显示方式(尽量使用枚举名称)
     */
    static func nodeImageNodeAddNode(addNode: ASDisplayNode, clipsToBounds: Bool, contentMode: UIView.ContentMode) -> ASImageNode {
        let imageNode: ASImageNode = ASImageNode()
        imageNode.clipsToBounds = clipsToBounds
        imageNode.contentMode = contentMode
        addNode.addSubnode(imageNode)
        return imageNode
    }
    
    /**
     NodeImageView(网络)
     
     @param addNode 添加View
     @param clipsToBounds 边界裁剪
     @param contentMode 显示方式(尽量使用枚举名称)
     @param defaultImage 占位图
     */
    static func nodeNetworkImageNodeAddNode(addNode: ASDisplayNode, clipsToBounds: Bool, contentMode: UIView.ContentMode, defaultImage: UIImage?) -> ASNetworkImageNode {
        let networkImageNode: ASNetworkImageNode = ASNetworkImageNode()
        networkImageNode.backgroundColor = UIColor.gray
        if let _ = defaultImage {
            networkImageNode.defaultImage = defaultImage
        }
        networkImageNode.clipsToBounds = clipsToBounds
        networkImageNode.contentMode = contentMode
        addNode.addSubnode(networkImageNode)
        return networkImageNode
    }

}
