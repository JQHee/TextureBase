//
//  BaseController.swift
//  TextureBase
//
//  Created by midland on 2018/12/13.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class BaseController<L>: UIViewController where L: ASDisplayNode {
    
    var layoutNode: L!
    
    func createView() -> L {
        return L()
    }
    
    override func loadView() {
        super.loadView()
        layoutNode = self.createView()
        self.view.addSubnode(layoutNode)
        if let delegate = UIApplication.shared.delegate {
            self.view.backgroundColor = delegate.window??.backgroundColor
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.layoutNode.frame = self.view.bounds
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            self.didBack()
        }
    }
    
    func didBack() {
        
    }
    
}
