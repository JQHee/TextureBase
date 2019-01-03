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
protocol PresenterToViewProtocol: class {
    func showNews(news: LiveNewsModel)
    func showError()
}

// MARK: - 请求数据后，将数据给Presenter
protocol InterectorToPresenterProtocol: class {
    func liveNewsFetched(news: LiveNewsModel)
    func liveNewsFetchedFailed()
}

// MARK: - Presentor让Interector请求网络数据
protocol PresentorToInterectorProtocol: class {
    var presenter: InterectorToPresenterProtocol? { get set }
    func fetchLiveNews()
}

// MARK: - View驱动Presenter
protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? { get set }
    var interector: PresentorToInterectorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func viewDidLoad()
    /* 跳转详情页 */
    func showPostDetail(news: LiveNewsModel)
}

// MARK: - Presenter驱动路由
protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
    func pushDetailVC(from view: PresenterToViewProtocol, news: LiveNewsModel)
}


