//
//  Global.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//
import WebKit

// 系统框架
@_exported import Foundation
@_exported import UIKit

// 第三方框架
@_exported import AsyncDisplayKit
@_exported import SnapKit
@_exported import MJRefresh
@_exported import YYWebImage
@_exported import SwiftyJSON

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

// 分页加载的数量
var kPageSize: Int {
    return 20
}

// 全局方法
// 获取主线程做相关操作
func dispatch_async_safely_main_queue(_ block: @escaping () -> Void) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async {
            block()
        }
    }
}

// DEBUG日志的打印
func print(_ something: @autoclosure () -> Any) {
    #if DEBUG
    let fileName = (#file as NSString).lastPathComponent
    Swift.print("\(fileName):(\(#line))-\(something())")
    #endif
}

// 本地是否有缓存
func haveCacheImage(key: String) -> Bool {
    return YYImageCache.shared().containsImage(forKey: key)
}

func cacheImage(key: String) -> UIImage? {
    return YYImageCache.shared().getImageForKey(key)
}

// 全局适配ios 11
func adapterIOS_11() {
    if #available(iOS 11.0, *) {
        // 适配iOS 11的系统
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        UITableView.appearance().estimatedRowHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        // 适配webview底部有黑色块的问题
        UIWebView.appearance().scrollView.contentInsetAdjustmentBehavior = .never
        WKWebView.appearance().scrollView.contentInsetAdjustmentBehavior = .never
        WKWebView.appearance().isOpaque = false
        UIWebView.appearance().isOpaque = false
    }
}
