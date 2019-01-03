//
//  LiveNewsPresenter.swift
//  Live News
//
//  Created by MacBook Pro 13" on 1/28/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation

class LiveNewsPresenter: NewsListViewToPresenterProtocol {

    // 不用weak回造成循环引用
    weak var view: NewsListPresenterToViewProtocol?
    var interector: NewsListPresentorToInterectorProtocol?
    var router: NewsListPresenterToRouterProtocol?
    
    func viewDidLoad() {
        interector?.fetchLiveNews()
    }
    
    func showPostDetail(news: LiveNewsModel) {
        router?.pushDetailVC(from: view!, news: news)
    }
    
    func showPostDetail(news: LiveNewsModel, callback: @escaping () -> ()) {
        router?.pushDetailVC(from: view!, news: news, callback: callback)
    }
}

extension LiveNewsPresenter: NewsListInterectorToPresenterProtocol {
	
	func liveNewsFetched(news: LiveNewsModel) {
        view?.showNews(news: news)
    }
    
    func liveNewsFetchedFailed(){
        view?.showError()
    }
}

