//
//  LiveNewsPresenter.swift
//  Live News
//
//  Created by MacBook Pro 13" on 1/28/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation

class LiveNewsPresenter: ViewToPresenterProtocol {

    var view: PresenterToViewProtocol?
    var interector: PresentorToInterectorProtocol?
    var router: PresenterToRouterProtocol?
    
    func viewDidLoad() {
        interector?.fetchLiveNews()
    }
    
    func showPostDetail(news: LiveNewsModel) {
        router?.pushDetailVC(from: view!, news: news)
    }
}

extension LiveNewsPresenter: InterectorToPresenterProtocol {
	
	func liveNewsFetched(news: LiveNewsModel) {
        view?.showNews(news: news)
    }
    
    func liveNewsFetchedFailed(){
        view?.showError()
    }
}

