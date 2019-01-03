//
//  LiveNewsDetailRouter.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import Foundation

class LiveNewsDetailRouter: NewsListDetailPresenterToRouterProtocol {

    static func createModule(news: LiveNewsModel) -> UIViewController {
        let view = NewsDetailView()
        let presenter: NewsListDetailViewToPresenterProtocol = LiveNewsDetailPresenter()
        // let interactor: PresentorToInterectorProtocol = LiveNewsInterector()
        let router: NewsListDetailPresenterToRouterProtocol = LiveNewsDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.news = news
        // presenter.interector = interactor
        // interactor.presenter = presenter
        return view
    }
    
    static func createModule(news: LiveNewsModel, callback: @escaping () -> ()) -> UIViewController {
        let view = NewsDetailView()
        let presenter: NewsListDetailViewToPresenterProtocol = LiveNewsDetailPresenter()
        // let interactor: PresentorToInterectorProtocol = LiveNewsInterector()
        let router: NewsListDetailPresenterToRouterProtocol = LiveNewsDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.news = news
        presenter.callback = callback
        // presenter.interector = interactor
        // interactor.presenter = presenter
        
        return view
    }
    
    func doPopBackFromeNewsListDetail(view: NewsListDetailPresenterToViewProtocol) {
       let controller = view
        controller.doPopBackFromeNewsListDetail()
    }
    
    deinit {
        print("LiveNewsDetailRouter deinit")
    }
    
}

