//
//  LiveNewsProtocols.swift
//  Live News
//
//  Created by MacBook Pro 13" on 2/4/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 将数据展示到View
protocol NewsListPresenterToViewProtocol: class {
    func showNews(news: LiveNewsModel)
    func showError()
}

// MARK: - 请求数据后，将数据给Presenter
protocol NewsListInterectorToPresenterProtocol: class {
    func liveNewsFetched(news: LiveNewsModel)
    func liveNewsFetchedFailed()
}

// MARK: - Presentor让Interector请求网络数据
protocol NewsListPresentorToInterectorProtocol: class {
    var presenter: NewsListInterectorToPresenterProtocol? { get set }
    func fetchLiveNews()
}

// MARK: - View驱动Presenter
protocol NewsListViewToPresenterProtocol: class {
    var view: NewsListPresenterToViewProtocol? { get set }
    var interector: NewsListPresentorToInterectorProtocol? { get set }
    var router: NewsListPresenterToRouterProtocol? { get set }
    func viewDidLoad()
    /* 跳转详情页 */
    func showPostDetail(news: LiveNewsModel)
    func showPostDetail(news: LiveNewsModel, callback: @escaping () -> ())
}

// MARK: - Presenter驱动路由
protocol NewsListPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
    func pushDetailVC(from view: NewsListPresenterToViewProtocol, news: LiveNewsModel)
    func pushDetailVC(from view: NewsListPresenterToViewProtocol, news: LiveNewsModel, callback: @escaping () -> ())
}


