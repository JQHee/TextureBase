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
  布局说明： https://www.jianshu.com/p/5d196b4f78cf
 布局的Demo: https://github.com/ysw-hello/TextureLayoutDemo
  ASDisplayKit的布局主要有两种， 一种是相对布局，一种是绝对布局
  绝对布局：ASAbsoluteLayoutSpec （不推荐使用）
  相对布局：ASStackLayoutSpec
 
 /// 说明：
 ASStackLayoutSpec是一个容器型布局，主要用于描述控件之间左右或者上下位置的关系（兄弟视图）。
 stack控件分为两个轴，主轴和十字轴，主轴的方向和direction方向平行。
 ASStackLayoutSpec.init(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [titleNode, imageNode])
 属性说明：
    direction： 主轴方向（排列方向：水平或垂直）
    spacing:    间距
    justifyContent： 主轴方向上子控件的排列方式
    alignItems：十字轴方向（也就是与当前主轴垂直的那条轴）上子控件的排列方式
    flexShrink，flexGrow 当该控件比父控件大时，则可以在当前主轴方向上缩小或者拉伸自己，直至在当前方向上填满父空间。
    spacingBefore ， spacingAfter 如果是水平方向，before表示前面的间距，after表示后面的间距。如果是垂直方向，before表示上面的间距，after表示下面的间距

 
ASLayoutSpec 相关API

ASStackLayoutSpec： 栈布局
ASAbsoluteLayoutSpec： 绝对布局
 
 ASBackgroundLayoutSpec： 背景布局
 这种布局模式用来描述z轴（在屏幕上展示也就是前后）方向上的两个控件位置关系，
 background控件会作为背景位于child控件正下方。整个控件的大小和background的大小由child大小决定。
 
ASOverlayLayoutSpec  ： 覆盖布局
 这种控件用来描述z轴（在屏幕上展示也就是前后）方向上的两个空间的位置关系，overlay控件会覆盖于child控件正上方。整个控件的大小和overlay的大小由child大小决定。
 
ASInsetLayoutSpec： 边距布局
 用来改变子控件的大小，该控件的大小由子控件大小 + UIEdgeInsets四个方向上的数值。该空间的位置保持子控件的位置不变。
 
ASRatioLayoutSpec： 比例布局
 ASRatioLayoutSpec :主要用于约束控件的 高宽比。
 ratio = 0.5, 空间的宽是高的2倍。
 ratio = 2.0, 空间的高是宽的2倍
 
ASRelativeLayoutSpec： 相对布局
 用来方便描述child在父控件中边角特殊位置。例如：左上角，上边界中间，右上角，左边界中间，正中间，右边界中间，左下角，下边界中间，右下角。
 
ASCenterLayoutSpec： 居中布局
是ASRelativeLayoutSpec的子类，专用于描述child在父控件中水平居中，垂直居中，正中。
 
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
