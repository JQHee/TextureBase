//
//  LiveNewsViewController.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import UIKit

class LiveNewsViewController: UIViewController {
    
    weak var presenter: ViewToPresenterProtocol?
    
    // 数据保存在View
    var news: LiveNewsModel?
    
    lazy var authorLabel: UILabel = UILabel()
    lazy var titleLabel: UILabel  = UILabel()
    lazy var descriptionLabel: UITextView = UITextView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "列表页"
        presenter?.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let model = self.news else { return }
        presenter?.showPostDetail(news: model)
    }
}

extension LiveNewsViewController: PresenterToViewProtocol {
    
    func showNews(news: LiveNewsModel) {
        self.news = news
        authorLabel.text = news.author
        titleLabel.text = news.title
        descriptionLabel.text = news.description
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
