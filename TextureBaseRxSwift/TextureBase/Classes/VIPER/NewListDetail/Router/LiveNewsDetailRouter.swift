//
//  LiveNewsDetailRouter.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import Foundation

class LiveNewsDetailRouter: PresenterToNewsDetailRouterProtocol {
    static func createModule(news: LiveNewsModel) -> UIViewController {
        let view = NewsDetailView()
        let presenter: DetailViewToPresenterProtocol = LiveNewsDetailPresenter()
        // let interactor: PresentorToInterectorProtocol = LiveNewsInterector()
        let router: PresenterToNewsDetailRouterProtocol = LiveNewsDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.news = news
        // presenter.interector = interactor
        // interactor.presenter = presenter
        
        return view
    }
}
