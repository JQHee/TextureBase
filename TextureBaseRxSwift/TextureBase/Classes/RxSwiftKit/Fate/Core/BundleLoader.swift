//
//  BundleLoader.swift
//  Fate
//
//  Created by Archer on 2018/11/26.
//

import Foundation

// MARK: 加载Fate.bundle里面的图片资源 (常用于组件化加载资源文件)

class BFBundleLoader: NSObject {}

extension Bundle {
    static let resourcesBundle: Bundle? = {
        var path = Bundle(for: BFBundleLoader.self).resourcePath ?? ""
        path.append("/BF.bundle")
        return Bundle(path: path)
    }()
}

extension UIImage {
    convenience init?(nameInBundle name: String) {
        self.init(named: name, in: .resourcesBundle, compatibleWith: nil)
    }
}
