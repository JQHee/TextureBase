//
//  DiscuListDetailHeaderView.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

class DiscuListDetailHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!

    static func loadNib() -> DiscuListDetailHeaderView {
        return Bundle.main.loadNibNamed("DiscuListDetailHeaderView", owner: nil, options: nil)?.last as! DiscuListDetailHeaderView
    }
    

}
