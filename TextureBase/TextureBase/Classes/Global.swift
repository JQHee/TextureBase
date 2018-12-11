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
