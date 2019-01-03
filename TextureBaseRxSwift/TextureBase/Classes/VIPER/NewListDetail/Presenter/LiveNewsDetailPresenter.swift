//
//  LiveNewsDetailPresenter.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import Foundation
import UIKit

class LiveNewsDetailPresenter: DetailViewToPresenterProtocol {
    
    var view: PresenterToDetailViewProtocol?
    // var interector: PresentorToInterectorProtocol?
    var router: PresenterToNewsDetailRouterProtocol?
    var news: LiveNewsModel?
    
    func viewDidLoad() {
        view?.showDataToNewsDetail(news: news!)
    }
    
}
