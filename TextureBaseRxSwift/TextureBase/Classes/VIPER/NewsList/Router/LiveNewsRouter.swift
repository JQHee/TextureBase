//
//  LiveNewsRouter.swift
//  Live News
//
//  Created by MacBook Pro 13" on 2/4/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation
import UIKit

class LiveNewsRouter: PresenterToRouterProtocol{

    
    
    class func createModule() ->UIViewController {
        let view = LiveNewsViewController()
        let nav = UINavigationController.init(rootViewController: view)
            // mainstoryboard.instantiateViewController(withIdentifier: "LiveNewsViewController") as? LiveNewsViewController;
        //if let view = navController.childViewControllers.first as? LiveNewsViewController {
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = LiveNewsPresenter()
        let interactor: PresentorToInterectorProtocol = LiveNewsInterector()
        let router: PresenterToRouterProtocol = LiveNewsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
            
        return nav
            
        //}
        
        //return UIViewController()
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
    func pushDetailVC(from view: PresenterToViewProtocol, news: LiveNewsModel) {
        
        let postDetailViewController = LiveNewsDetailRouter.createModule(news: news)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
}
