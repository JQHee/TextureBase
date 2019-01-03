//
//  AppDelegate.swift
//  TextureBase
//
//  Created by midland on 2018/12/11.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import GDPerformanceView_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainVC = BFTabBarController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        setupRootVC()
        // FPS
        PerformanceMonitor.shared().start()
        adapterIOS_11()
        return true
    }

    func setupFirstRootVC() {
        mainVC.setupRootVC()
    }

    func setupRootVC() {
        
        /**
         测试redux
         */
//        let reator = ViewControllerReactor()
//        let VC = BFViewController()
//        VC.reactor = reator
//        let nav = UINavigationController.init(rootViewController: VC)
//        self.window?.rootViewController = nav
        
        /**
         测试VIPER架构
         */
        let liveNews = LiveNewsRouter.createModule()
        self.window?.rootViewController = liveNews
        /*
        guard let isFirstLoad = UserDefaults.standard.value(forKey: "isFirstLoad") as? Bool else {
            self.window?.rootViewController = GuidePageViewController()
            return
        }
        print(isFirstLoad)
        mainVC.setupRootVC()
        addADLaunchController()
         */
    }

    // 添加广告页
    func addADLaunchController() {
        guard let window = UIApplication.shared.windows.last else {
            return
        }
        let VC = ADLaunchController()
        mainVC.addChild(VC)
        VC.view.frame = UIScreen.main.bounds
        window.addSubview(VC.view)

    }

}

// MARK: - 应用的生命周期
extension AppDelegate {
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {
    func restoreRootViewController(newRootVC: UIViewController) {
        guard let window = window else { return}

        newRootVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                            let oldState = UIView.areAnimationsEnabled
                            UIView.setAnimationsEnabled(false)
                            window.rootViewController = newRootVC
                            UIView.setAnimationsEnabled(oldState)
        },
                          completion: { (finished: Bool) in

        })
    }
}

