//
//  NewsDetailView.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import UIKit

class NewsDetailView: UIViewController {
    
    var presenter: NewsListDetailViewToPresenterProtocol?
    
    var callback: (() -> ())?

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
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = self.callback {
            self.callback!()
        }
       self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Lazy load
    private lazy var textLabel: UILabel = UILabel()

}

extension NewsDetailView: NewsListDetailPresenterToViewProtocol {
    
    func showDataToNewsDetail(news: LiveNewsModel, callback: @escaping () -> ()) {
        print("有callback参数")
        self.callback = callback
        textLabel.text = news.title ?? ""
    }
    
    // 暂时列表传过来的数据
    func showDataToNewsDetail(news: LiveNewsModel) {
        print("详情页展示数据")
        textLabel.text = news.title ?? ""
    }
}
