//
//  InfomationDetailSectionView.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

class InfomationDetailSectionHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundView = UIView.init(frame: bounds)
        self.backgroundView?.backgroundColor = UIColor.white
    }
}
