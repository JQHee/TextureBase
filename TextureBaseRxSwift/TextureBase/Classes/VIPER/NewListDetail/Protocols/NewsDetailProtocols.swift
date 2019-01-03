//
//  NewsDetailProtocols.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import Foundation
import UIKit


// MARK: - 将数据展示到View
protocol PresenterToDetailViewProtocol: class {
    func showDataToNewsDetail(news: LiveNewsModel)
}

// MARK: - View驱动Presenter
protocol DetailViewToPresenterProtocol: class {
    var view: PresenterToDetailViewProtocol? { get set }
    // var interector: PresentorToInterectorProtocol? { get set }
    var router: PresenterToNewsDetailRouterProtocol? { get set }
    var news: LiveNewsModel? { get set }
    func viewDidLoad()
}

// MARK: - Presenter驱动路由
protocol PresenterToNewsDetailRouterProtocol: class {
    static func createModule(news: LiveNewsModel) -> UIViewController
}
