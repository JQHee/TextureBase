//
//  HotRecommentSectionView.swift
//  TextureBase
//
//  Created by midland on 2018/12/18.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

class HotRecommentSectionView: UITableViewHeaderFooterView {


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        // HotRecommentSectionView.loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        #warning("UITableViewHeaderFooterView 无法设置背景颜色的方法")
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = UIColor.white
    }

    static func loadNib() -> HotRecommentSectionView {
        return Bundle.main.loadNibNamed("HotRecommentSectionView", owner: nil, options: nil)?.last as! HotRecommentSectionView
    }

}
