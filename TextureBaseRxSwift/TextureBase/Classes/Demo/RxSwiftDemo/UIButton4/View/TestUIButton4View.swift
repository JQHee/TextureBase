//
//  TestUIButton4View.swift
//  TextureBase
//
//  Created by midland on 2018/12/29.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestUIButton4View: UIView {

    let loginCommand = PublishSubject<Void>()
    let button = UIButton()
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.rx.tap.subscribe(onNext: { (_) in
            self.loginCommand.asObserver().onNext(())
        }).disposed(by: disposeBag)
    }
  
}
