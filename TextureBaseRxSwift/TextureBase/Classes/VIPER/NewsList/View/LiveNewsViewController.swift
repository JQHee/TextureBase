//
//  LiveNewsViewController.swift
//  TextureBase
//
//  Created by midland on 2019/1/3.
//  Copyright © 2019年 ml. All rights reserved.
//

import UIKit

class LiveNewsViewController: UIViewController {
    
    var presenter: NewsListViewToPresenterProtocol?
    
    let disposeBag = DisposeBag()
    
    // 数据保存在View
    var news: LiveNewsModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "列表页"
        view.backgroundColor = UIColor.white
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /*
        BFRxNetRequest.shared.request(target: ApiManager.testHome)?.subscribe(onNext: { (respose) in
            do {
                //过滤成功的状态码响应
                let data = try respose.mapJSON()
                print(data)
                //继续做一些其它事情....
            }
            catch {
                //处理错误状态码的响应...
            }
            print(respose)
            
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
         */
        
        BFRxNetRequest.shared.send(target: ApiManager.testHome)?.subscribe(onNext: { (result) in
            do {
                //过滤成功的状态码响应
                let data = try result.response?.mapJSON()
                print(data ?? "")
                //继续做一些其它事情....
            }
            catch {
                //处理错误状态码的响应...
            }
        }).disposed(by: disposeBag)
        
//        // 跳转新闻详情页
//        guard let model = self.news else { return }
//        presenter?.showPostDetail(news: model, callback: {
//            print("callback")
//        })

    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(authorLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        authorLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(21)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(21)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
    }
    
    // MARK: - Lazy load
    lazy var authorLabel: UILabel = UILabel()
    lazy var titleLabel: UILabel  = UILabel()
    lazy var descriptionLabel: UITextView = UITextView()
}

extension LiveNewsViewController: NewsListPresenterToViewProtocol {
    
    func showNews(news: LiveNewsModel) {
        self.news = news
        authorLabel.text = "作者：" + (news.author ?? "")
        titleLabel.text = "标题：" + (news.title ?? "")
        descriptionLabel.text = "内容：" + (news.description ?? "")
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
