//
//  BaseNavigationViewController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    private func setupNavBar() {
        let navBar = UINavigationBar.appearance()
        /// 把这个半透明关闭，不然会影响布局
        navBar.isTranslucent = false
        navBar.barTintColor = UIColor.black
        navBar.barStyle = .black
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        navBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}

extension BaseNavigationViewController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if viewControllers.count > 0 {
            // 进入新页面隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            //viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_white"), style: .plain, target: self, action: Action.navigationBackClickAction)
        }

        let backItem = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backItem

        super.pushViewController(viewController, animated: animated)
        // 获取tabBar的frame, 如果没有直接返回
        guard var frame = self.tabBarController?.tabBar.frame else {
            return
        }
        // 设置frame的y值, y = 屏幕高度 - tabBar高度
        frame.origin.y = UIScreen.main.bounds.size.height - frame.size.height
        // 修改tabBar的frame
        self.tabBarController?.tabBar.frame = frame
    }

}
