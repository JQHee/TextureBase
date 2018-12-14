//
//  ASDisplayNode+Extension.swift
//  TextureBase
//
//  Created by midland on 2018/12/14.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

extension ASDisplayNode {
    
    // 添加圆角或边框
    func maskNodeBound(borderWidth: CGFloat, radius: CGFloat, borderColor: UIColor) {
        self.borderColor = borderColor.cgColor
        self.borderWidth = borderWidth
        self.cornerRadius = radius
        self.clipsToBounds = true
    }
}
