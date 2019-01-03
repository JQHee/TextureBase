//
//  NewsDetailView.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import UIKit

class NewsDetailView: UIViewController {
    
    // 不用weak回造成循环引用
    weak var presenter: DetailViewToPresenterProtocol?

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "详情页"
        self.view.backgroundColor = UIColor.orange
        presenter?.viewDidLoad()
    }
    
}

extension NewsDetailView: PresenterToDetailViewProtocol {
    // 暂时列表传过来的数据
    func showDataToNewsDetail(news: LiveNewsModel) {
        print("详情页展示数据")
    }
}
