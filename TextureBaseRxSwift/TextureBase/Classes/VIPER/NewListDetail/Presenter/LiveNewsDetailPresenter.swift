//
//  LiveNewsDetailPresenter.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import Foundation
import UIKit

class LiveNewsDetailPresenter: NewsListDetailViewToPresenterProtocol {
    
    // 不用weak回造成循环引用
    weak var view: NewsListDetailPresenterToViewProtocol?
    // var interector: PresentorToInterectorProtocol?
    var router: NewsListDetailPresenterToRouterProtocol?
    var news: LiveNewsModel?
    var callback: (() -> ())?
    
    func viewDidLoad() {
        // view?.showDataToNewsDetail(news: news!)
        view?.showDataToNewsDetail(news: news!, callback: callback!)
    }
    
    func goBackAction() {
        router?.doPopBackFromeNewsListDetail(view: view!)
    }
}
