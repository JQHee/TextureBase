//
//  UIView+Extension.swift
//  TextureBase
//
//  Created by midland on 2018/12/20.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation

extension UIView {
    
    @objc public func viewContainingController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
}
