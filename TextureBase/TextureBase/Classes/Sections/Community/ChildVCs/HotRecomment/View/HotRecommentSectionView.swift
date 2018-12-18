//
//  HotRecommentSectionView.swift
//  TextureBase
//
//  Created by midland on 2018/12/18.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

class HotRecommentSectionView: UIView {

    static func loadNib() -> HotRecommentSectionView {
        return Bundle.main.loadNibNamed("HotRecommentSectionView", owner: nil, options: nil)?.last as! HotRecommentSectionView
    }

}
