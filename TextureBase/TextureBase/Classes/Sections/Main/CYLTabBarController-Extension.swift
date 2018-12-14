//
//  CYLTabBarController-Extension.swift
//  Swift_baseFramework
//
//  Created by HJQ on 2018/1/8.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation
import UIKit
// @_exported 使用这种方式导入就不需要每个文件导入头文件了
@_exported import CYLTabBarController

extension CYLTabBarController {
    
    class func customizeTabbar() {
        // 普通状态下的文字属性
        var normalAttrs = [NSAttributedString.Key: Any]()
        normalAttrs[NSAttributedString.Key.foregroundColor] = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        
        // 选中状态下的文字属性
        var selectedAttrs = [NSAttributedString.Key: AnyObject]()
        selectedAttrs[NSAttributedString.Key.foregroundColor] = UIColor(red: 55.0/255.0, green: 172.0/255.0, blue: 104.0/255.0, alpha: 1.0)
        
        // 设置文字属性
        let tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes(normalAttrs, for: UIControl.State())
        tabBar.setTitleTextAttributes(selectedAttrs, for: .selected)
        
        // 设置背景图片
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    }
    
    /// 全功能界面
    class func fullFunction() {
        
        CYLTabBarController.customizeTabbar()
        
        var vcs = [UIViewController]()
        var dicts = [[String: String]]()
        
        let informationVC = InfomationViewController()
        let informationNav = BaseNavigationViewController.init(rootViewController: informationVC)
        vcs += [informationNav]
        dicts += [[CYLTabBarItemTitle: "资讯",
                       CYLTabBarItemImage: "icon_zx_nomal_pgall",
                       CYLTabBarItemSelectedImage: "icon_zx_pressed_pgall"]]

        let selectVC = SelectViewController()
        let selectNav = BaseNavigationViewController.init(rootViewController: selectVC)
        vcs += [selectNav]
        dicts += [[CYLTabBarItemTitle: "精选",
                       CYLTabBarItemImage: "icon_jx_nomal_pgall",
                       CYLTabBarItemSelectedImage: "icon_jx_pressed_pgall"]]

        let communityVC = CommunityViewController()
        let communityNav = BaseNavigationViewController.init(rootViewController: communityVC)
        vcs += [communityNav]
        dicts += [[CYLTabBarItemTitle: "社区",
                   CYLTabBarItemImage: "icon_sq_nomal_pgall",
                   CYLTabBarItemSelectedImage: "icon_sq_pressed_pgall"]]

        let mineVC = MineViewController()
        let mineNav = BaseNavigationViewController.init(rootViewController: mineVC)
        vcs += [mineNav]
        dicts += [[CYLTabBarItemTitle: "我的",
                   CYLTabBarItemImage: "icon_w_nomal_pgall",
                   CYLTabBarItemSelectedImage: "icon_w_pressed_pgall"]]

        guard dicts.count > 0 else {
            return
        }
        
        guard let tabVC = CYLTabBarController(viewControllers: vcs,
                                              tabBarItemsAttributes: dicts) else {
                                                return
        }
        // 可以使用imageview设置选中的动画
        if let appDelegate = UIApplication.shared.delegate as? UITabBarControllerDelegate {
            tabVC.delegate = appDelegate
        }
        (UIApplication.shared.delegate as? AppDelegate)?.restoreRootViewController(newRootVC: tabVC)
        tabVC.setViewDidLayoutSubViewsBlock { (tabBarController: CYLTabBarController?) in
            tabBarController?.viewControllers[1].cyl_tabButton.cyl_tabBadgePointView = UIView.cyl_tabBadgePointView(withClolor: UIColor.red, radius: 4.5)
        }
    }
}

// MARK: - 自定义 TabBarController
class BFTabBarController: CYLTabBarController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()
    }
    
    // MARK: - Private methods
    // MARK: - Private methdos
    func setupRootVC() {
        BFTabBarController.fullFunction()
    }
    
    // 监听登录状态
    private func viewBindEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(loginAction), name: NSNotification.Name.init("login"), object: nil)
    }
    
    @objc private func loginAction() {
        // 登录逻辑
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
