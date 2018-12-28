//
//  InfomationDetailHeaderView.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

class InfomationDetailHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static func loadNib() -> InfomationDetailHeaderView {
        return Bundle.main.loadNibNamed("InfomationDetailHeaderView", owner: nil, options: nil)?.last as! InfomationDetailHeaderView
    }

}
