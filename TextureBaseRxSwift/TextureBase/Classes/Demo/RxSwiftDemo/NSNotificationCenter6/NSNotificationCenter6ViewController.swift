//
//  NSNotificationCenter6ViewController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/30.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NSNotificationCenter6ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = NotificationCenter.default.rx.notification(Notification.Name.init(rawValue: "key"))
            .takeUntil(self.rx.deallocated) //页面销毁自动移除通知监听
            .subscribe(onNext: { (notification) in
                print(notification.object ?? notification.userInfo ?? "")
        })


        //监听键盘弹出通知
        _ = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .takeUntil(self.rx.deallocated) //页面销毁自动移除通知监听
            .subscribe(onNext: { _ in
                print("键盘出现了")
            })

        //监听键盘隐藏通知
        _ = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .takeUntil(self.rx.deallocated) //页面销毁自动移除通知监听
            .subscribe(onNext: { _ in
                print("键盘消失了")
            })

    }

}
