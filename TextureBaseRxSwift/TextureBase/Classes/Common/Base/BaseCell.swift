//
//  BaseCell.swift
//  TextureBase
//
//  Created by midland on 2018/12/13.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class BaseCell<T>: ASCellNode {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.2
            } else {
                alpha = 1
            }
        }
    }
    
    required init(item: T) {
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
}
