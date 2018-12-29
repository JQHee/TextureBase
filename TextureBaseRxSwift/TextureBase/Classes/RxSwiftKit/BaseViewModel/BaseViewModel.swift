//
//  BaseViewModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/29.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxDataSources

class BaseViewModel: NSObject {
    
    let provider = MoyaProvider<ApiManager>()
    var disposeBag = DisposeBag()
    var page: Int = 1

}

/*
class FirstViewModel: BaseViewModel {
    
    func getNewsData(completed: @escaping (_ model: ListModel) -> ()) {
        
        provider.request(.News)
            .mapModel(ListModel.self)
            .subscribe(onNext: { model in
                completed(model)
            }, onError: { error in
                
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
 */

// TableView的使用： https://www.jianshu.com/p/4d9447d5278a
