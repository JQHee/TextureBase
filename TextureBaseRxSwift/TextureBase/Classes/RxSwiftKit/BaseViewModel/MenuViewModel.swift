//
//  MenuViewModel.swift
//  TextureBase
//
//  Created by midland on 2018/12/29.
//  Copyright © 2018年 ml. All rights reserved.
//

import UIKit

// MARK: - 普通的请求
class MenuViewModel: NSObject {
    
    let models = Variable<[String]>([])
}

extension MenuViewModel: BFViewModelType {
    
    typealias Input = MenuViewModelInput
    typealias Output = MenuViewModelOutput
    
    struct MenuViewModelInput {
        let imageNameArr: [String] = []
        let titleArr: [String] = []
    }
    
    struct MenuViewModelOutput {
        // let sections: Driver<[LXFMenuSection]>
        let requestCommand = PublishSubject<Void>()
    }
    
    func transform(input: MenuViewModel.MenuViewModelInput) -> MenuViewModel.MenuViewModelOutput {
        
        let output = MenuViewModelOutput()
        return output
    }
    
}


// 带刷新功能的

class RecommentViewModel: NSObject {
    
    private let vmDatas = Variable<[String]>( [])
    var disposeBag = DisposeBag()

}

extension RecommentViewModel: BFViewModelType {
    
    typealias Input = RecommentViewModelInput
    typealias Output = RecommentViewModelOutput
    
    struct RecommentViewModelInput {
        let imageNameArr: [String] = []
        var titleArr: [String] = []
        
        mutating func setTitleArray(titleArr: [String]) {
            self.titleArr = titleArr
        }
    }
    
    struct RecommentViewModelOutput: OutputRefreshProtocol {
        var refreshStatus: Variable<BFRefreshStatus>
        let sections: Driver<[String]>
        let requestCommand = PublishSubject<Bool>()
        init(sections: Driver<[String]>) {
            self.sections = sections
            self.refreshStatus = Variable<BFRefreshStatus>(.none)
        }
    }
    
    func transform(input: RecommentViewModel.RecommentViewModelInput) -> RecommentViewModel.RecommentViewModelOutput {
        
        let tempSections = vmDatas.asDriver().map {$0}.asDriver(onErrorJustReturn: [])
        
        let output = RecommentViewModelOutput.init(sections: tempSections)
        output.requestCommand.asObserver().subscribe(onNext: { [weak self](isPull) in
            guard let `self` = self else {
                return
            }
            print(self)
        }).disposed(by: disposeBag)
        
        return output
    }
    
}

/* VC中发起自动刷新
vmOutput = viewModel.transform(input: RecommentViewModel.RecommentViewModelInput)

vmOutput?.sections.drive(recommendCollectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)

refreshHeader = initRefreshHeader(recommendCollectionView) { [weak self] in
    self?.vmOutput?.requestCommand.onNext(true)
}
let refreshFooter = initRefreshFooter(recommendCollectionView) { [weak self] in
    self?.vmOutput?.requestCommand.onNext(false)
}

vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: refreshFooter).disposed(by: rx.disposeBag)
 */
