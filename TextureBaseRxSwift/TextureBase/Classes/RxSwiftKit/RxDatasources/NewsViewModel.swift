//
//  NewsViewModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/29.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class NewsViewModel: BaseViewModel, UITableViewDelegate {
    
    /** 释放资源属性 */
    // let disposeBag = DisposeBag()
    /** 资源类属性 */
    
    // RxTableViewSectionedReloadDataSource<SectionModel<String,NewsModel>>()
    /** 新闻数据 */
    var news = [NewsModel]()
    var tableView: UITableView!
    
    //MARK: - 配置基础设置
    
    func prepare(tableView: UITableView) {
        self.tableView = tableView
        //设置tableView的delegate
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String,NewsModel>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(element)"
                return cell
            })
        
        /*
        dataSource.configureCell = {dataSource,tableView,indexPath,new in
            let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
            cell.config(new.dec, date: new.date)
            return cell
        }
         */
        
        //创建数据
        for _ in 0..<9 {
            let new = NewsModel(pic: "", dec: "LOL测试服：狼人皮肤调整 酒桶被动增强", date: "2016-07-01")
            news.append(new)
        }
        let sections = [
            SectionModel(model: "", items: news)
        ]
        //订阅被观察者
        let items = Observable.just(sections)
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
}
