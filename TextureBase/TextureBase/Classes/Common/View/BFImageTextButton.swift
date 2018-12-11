//
//  BFImageTextButton.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

class BFImageTextButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFill
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX: CGFloat = 0.0
        let titleY: CGFloat = contentRect.height * 0.75
        let titleW: CGFloat = contentRect.width
        let titleH: CGFloat = contentRect.height - titleY
        return CGRect.init(x: titleX, y: titleY, width: titleW, height: titleH)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW = contentRect.width
        let imageH = contentRect.height * 0.7
        return CGRect.init(x: 0, y: 0, width: imageW, height: imageH)
    }
}
