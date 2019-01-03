//
//  NewsDetailProtocols.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import Foundation
import UIKit

protocol NewsDetailViewable: class {
    func doPopBackFromeNewsListDetail()
}

// MARK: - 将数据展示到View
protocol NewsListDetailPresenterToViewProtocol: class {
    func showDataToNewsDetail(news: LiveNewsModel)
    func showDataToNewsDetail(news: LiveNewsModel, callback: @escaping() -> ())
    func doPopBackFromeNewsListDetail()
}

// MARK: - View驱动Presenter
protocol NewsListDetailViewToPresenterProtocol: class {
    var view: NewsListDetailPresenterToViewProtocol? { get set }
    // var interector: PresentorToInterectorProtocol? { get set }
    var router: NewsListDetailPresenterToRouterProtocol? { get set }
    var news: LiveNewsModel? { get set }
    var callback: (() -> ())? { get set }
    func viewDidLoad()
    func goBackAction()
}

// MARK: - Presenter驱动路由
protocol NewsListDetailPresenterToRouterProtocol: class {
    static func createModule(news: LiveNewsModel) -> UIViewController
    static func createModule(news: LiveNewsModel, callback: @escaping () -> ()) -> UIViewController
    func doPopBackFromeNewsListDetail(view: NewsListDetailPresenterToViewProtocol)
}
