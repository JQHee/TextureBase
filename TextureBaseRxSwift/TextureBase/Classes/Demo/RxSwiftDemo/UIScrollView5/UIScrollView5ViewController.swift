//
//  UIScrollView5ViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/29.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

class UIScrollView5ViewController: UIViewController {

    let scrollView = UIScrollView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.rx.didScroll.subscribe(onNext: { () in
            let currentX = self.scrollView.contentOffset.x

        }).disposed(by:  disposeBag)

    }
    


}
