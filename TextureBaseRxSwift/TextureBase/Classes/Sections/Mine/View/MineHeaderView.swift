//
//  MineHeaderView.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    static func loadNib() -> MineHeaderView {
        return Bundle.main.loadNibNamed("MineHeaderView", owner: nil, options: nil)?.last as! MineHeaderView
    }

}
