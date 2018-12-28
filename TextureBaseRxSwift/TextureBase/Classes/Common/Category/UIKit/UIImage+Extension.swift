//
//  UIImage+Extension.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/12.
//  Copyright © 2018 ml. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func toCircle() -> UIImage {
        let shotest = min(self.size.width, self.size.height)
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        context.addEllipse(in: outputRect)
        context.clip()
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
}
