//
//  UIButton4ViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/28.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UIButton4ViewController: UIViewController {
    
    let button = UIButton()
     let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //按钮点击响应
        button.rx.tap
            .subscribe({[weak self] _ in
                print(self ?? "")
            })
            .disposed(by: disposeBag)
        
        //按钮点击响应
        button.rx.tap
            .bind { [weak self] in
                print(self ?? "")
            }
            .disposed(by: disposeBag)

    }
    

}
