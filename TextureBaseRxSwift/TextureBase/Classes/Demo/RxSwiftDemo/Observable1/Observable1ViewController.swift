//
//  Observable1ViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/28.
//  Copyright © 2018年 ml. All rights reserved.
//

/**
 1.Observable介绍、创建可观察序列
 */

import UIKit
import RxSwift
import RxCocoa

class Observable1ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - 创建序列
    // just() 该方法通过传入一个默认值来初始化
    // of()  该方法可以接受可变数量的参数（必需要是同类型的）
    // from() 该方法需要一个数组参数
    // empty() 该方法创建一个空内容的 Observable 序列
    // never() 该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列
    // error() 该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列
    // range() 该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的 Observable 序列
    // repeatElement() 该方法创建一个可以无限发出给定元素的 Event 的 Observable 序列（永不终止)
    // generate() 该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列
    // create() 该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理
    private func testJust() {
        _ = Observable<Int>.just(5)
        _ = Observable<String>.of("A", "B", "C")
        
        
        // error
        enum MyError: Error {
            case A
            case B
        }
        _ = Observable<Int>.error(MyError.A)
        
        // rang
        _ = Observable.range(start: 1, count: 5)
        
        // generate
        _ = Observable.generate(initialState: 0, condition: { $0 <= 10}, iterate: { $0 + 2 })
        _ = Observable.of(0 , 2 ,4 ,6 ,8 ,10)
    }
    
    private func testCreate() {
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        
        //订阅测试
        _ = observable.subscribe {
            print($0)
        }
    }
    
    // deferred() 该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable 序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方
    private func testDeferred() {
        //用于标记是奇数、还是偶数
        var isOdd = true
        
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
            
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
            
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        //第1次订阅测试
        _ = factory.subscribe { event in
            print("\(isOdd)", event)
        }
        
        //第2次订阅测试
        _ = factory.subscribe { event in
            print("\(isOdd)", event)
        }
    }
    
    // interval() 这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去
    // 每秒执行一次
    private func testInterval() {
        let observable = Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
        _ = observable.subscribe { event in
            print(event)
        }
    }
    
    // timer()  这个方法有两种用法，一种是创建的 Observable 序列在经过设定的一段时间后，产生唯一的一个元素
    // 另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素
    private func testTimer() {
        //5秒种后发出唯一的一个元素0
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        _ = observable.subscribe { event in
            print(event)
        }
        
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable2 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        _ = observable2.subscribe { event in
            print(event)
        }
    }
    
}

// MARK: - AnyObserver、Binder
extension Observable1ViewController {
    
    // AnyObserver 可以用来描叙任意一种观察者。
    
    private func testAnyObserver() {
        //观察者
        let observer: AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        let observable = Observable.of("A", "B", "C")
        observable.subscribe(observer)
        
        
        /* 配合bindTo使用
        // 观察者
        let observer: AnyObserver<String> = AnyObserver { [weak self] (event) in
            switch event {
            case .next(let text):
                //收到发出的索引数后显示到label上
                self?.label.text = text
            default:
                break
            }
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: observer)
            .disposed(by: disposeBag)
         */
    }
    
    /** Binder
     （1）相较于 AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征：
     不会处理错误事件
     确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
     （2）一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。
     */
    private func testBuilder() {
        /*
        //观察者
        let observer: Binder<String> = Binder(label) { (view, text) in
            //收到发出的索引数后显示到label上
            view.text = text
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: observer)
            .disposed(by: disposeBag)
         */
    }
}
