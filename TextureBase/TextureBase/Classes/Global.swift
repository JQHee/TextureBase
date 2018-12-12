//
//  Global.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//

// 系统框架
@_exported import Foundation
@_exported import UIKit

// 第三方框架
@_exported import AsyncDisplayKit
@_exported import SnapKit
@_exported import MJRefresh
@_exported import YYWebImage

// 常量
var kScreenW: CGFloat {
    return UIScreen.main.bounds.width
}

var kScreenH: CGFloat {
    return UIScreen.main.bounds.height
}

var kStaBarH: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}

var kNavBarH: CGFloat {
    return 44.0
}

// 全局方法
// 获取主线程做相关操作
func dispatch_sync_safely_main_queue(_ block: () -> Void) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.sync {
            block()
        }
    }
}

// 本地是否有缓存
func haveCacheImage(key: String) -> Bool {
    return YYImageCache.shared().containsImage(forKey: key)
}

func cacheImage(key: String) -> UIImage? {
    return YYImageCache.shared().getImageForKey(key)
}
