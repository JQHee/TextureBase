//
//  NSString+TextNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
     Node富文本
     
     @param text 文本
     @param textColor 文本颜色
     @param font 字体
     */
    func nodeAttributes(color: UIColor, font: UIFont) -> NSAttributedString {
        let attributesDic = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
        let attributesString = NSAttributedString.init(string: self, attributes: attributesDic)
        return attributesString
    }

    /**
     Node富文本

     @param text 文本
     @param textColor 文本颜色
     @param font 字体
     @param alignment 水平对齐方式
     */
    func nodeAttributes(color: UIColor, font: UIFont, alignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let attributesDic = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let attributesString = NSAttributedString.init(string: self, attributes: attributesDic)
        return attributesString
    }
}
