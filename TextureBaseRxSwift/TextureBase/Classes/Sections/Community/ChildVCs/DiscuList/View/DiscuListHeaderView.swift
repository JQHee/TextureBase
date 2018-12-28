//
//  DiscuListHeaderView.swift
//  TextureBase
//
//  Created by midland on 2018/12/19.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

// 论坛头部
class DiscuListHeaderView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    static func loadNib() -> DiscuListHeaderView {
        return Bundle.main.loadNibNamed("DiscuListHeaderView", owner: nil, options: nil)?.last as! DiscuListHeaderView
    }
    
}
