//
//  LiveNewsRouter.swift
//  Live News
//
//  Created by MacBook Pro 13" on 2/4/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation
import UIKit

class LiveNewsRouter: NewsListPresenterToRouterProtocol {

    static func createModule() -> UIViewController {
        let view = LiveNewsViewController()
        let nav = UINavigationController.init(rootViewController: view)
        // 使用storyboard开发
        // mainstoryboard.instantiateViewController(withIdentifier: "LiveNewsViewController") as? LiveNewsViewController;
        // if let view = navController.childViewControllers.first as? LiveNewsViewController {
        let presenter: NewsListViewToPresenterProtocol & NewsListInterectorToPresenterProtocol = LiveNewsPresenter()
        let interactor: NewsListPresentorToInterectorProtocol = LiveNewsInterector()
        let router: NewsListPresenterToRouterProtocol = LiveNewsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
            
        return nav
            
        //}
        
        //return UIViewController()
    }
    
    var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    // 跳转新闻详情
    func pushDetailVC(from view: NewsListPresenterToViewProtocol, news: LiveNewsModel) {
        
        let postDetailViewController = LiveNewsDetailRouter.createModule(news: news)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
    
    // 跳转新闻详情
    func pushDetailVC(from view: NewsListPresenterToViewProtocol, news: LiveNewsModel, callback: @escaping () -> ()) {
        
        let postDetailViewController = LiveNewsDetailRouter.createModule(news: news, callback: callback)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
    
    deinit {
        print("LiveNewsRouter deinit")
    }
}
