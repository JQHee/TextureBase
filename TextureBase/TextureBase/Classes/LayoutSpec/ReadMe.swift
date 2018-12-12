//
//  ReadMe.swift
//  TextureBase
//
//  Created by midland on 2018/12/12.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation

// 布局方式有两种： frame布局和flexbox式的布局

/*
// 1.自定义node
 override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    // 请在这里进行布局
 }

// 2.没有自定义node
self.node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *node, ASSizeRange constrainedSize) {
    
    请在这里进行布局
};
 */

/*
ASLayoutSpec 相关API

ASStackLayoutSpec： 栈布局

ASAbsoluteLayoutSpec： 绝对布局

ASBackgroundLayoutSpec： 背景布局

ASOverlayLayoutSpec  ： 覆盖布局

ASInsetLayoutSpec： 边距布局

ASRatioLayoutSpec： 比例布局

ASRelativeLayoutSpec： 相对布局

ASCenterLayoutSpec： 居中布局

ASWrapperLayoutSpec： 填充布局

ASCornerLayoutSpec： 圆角布局
 */

/* 1.设置任意间距
override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    nodeB.style.spaceBefore = 15
    nodeC.stlye.spaceBefore = 5
    
    return ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .start, children: [nodeA, nodeB, nodeC])
}
*/

/** 2.flexGrow和flexShrink
 flexGrow和flexShrink是相当重要的概念，flexGrow是指当有多余空间时，拉伸谁以及相应的拉伸比例（当有多个元素设置了flexGrow时），flexShrink相反，是指当空间不够时，压缩谁及相应的压缩比例（当有多个元素设置了flexShrink时）
 */
/* 2.1 两个元素等间距
import AsyncDisplayKit
class ContainerNode: ASDisplayNode {
    let nodeA = ASDisplayNode()
    let nodeB = ASDisplayNode()
    override init() {
        super.init()
        addSubnode(nodeA)
        addSubnode(nodeB)
    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacer1 = ASLayoutSpec()
        let spacer2 = ASLayoutSpec()
        let spacer3 = ASLayoutSpec()
        spacer1.stlye.flexGrow = 1
        spacer2.stlye.flexGrow = 1
        spacer3.stlye.flexGrow = 1
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .start, children: [spacer1, nodeA,spacer2, nodeB, spacer3])
    }
}
 */

/* 2.2 指定间距的宽度
override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let spacer1 = ASLayoutSpec()
    let spacer2 = ASLayoutSpec()
    let spacer3 = ASLayoutSpec()
    spacer1.stlye.flexGrow = 2
    // 指定间距
    spacer2.stlye.width = ASDimensionMake(100)
    spacer3.stlye.flexGrow = 1
    
    return ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .start, children: [spacer1, nodeA,spacer2, nodeB, spacer3])
}
 */

/** 3.constrainedSize的理解
 constrainedSize是指某个node的大小取值范围，有minSize和maxSize两个属性
 */
/*
import AsyncDisplayKit
class ContainerNode: ASDisplayNode {
    let nodeA = ASDisplayNode()
    let nodeB = ASDisplayNode()
    override init() {
        super.init()
        addSubnode(nodeA)
        addSubnode(nodeB)
        nodeA.style.preferredSize = CGSize(width: 100, height: 100)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        nodeB.style.flexShrink = 1
        nodeB.style.flexGrow = 1
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: e, justifyContent: .start, alignItems: .start, children: [nodeA, nodeB])
        return ASInsetLayoutSpec(insets: UIEdgeInsetsMake(a, b, c, d), child: stack)
    }
}
 */


// -------------------------------------------------------------------------------

/* frame布局和flexbox式的布局动画
 * 1.第一种可以使用UIView动画
 * 2.第二种使用下面的方式在配合UIView的动画
 */
/*
override func animateLayoutTransition(_ context: ASContextTransitioning) {
    添加UIView动画
}
 */
