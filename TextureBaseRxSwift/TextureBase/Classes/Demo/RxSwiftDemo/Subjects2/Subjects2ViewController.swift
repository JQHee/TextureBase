//
//  Subjects2ViewController.swift
//  TextureBase
//
//  Created by midland on 2018/12/28.
//  Copyright © 2018年 ml. All rights reserved.
//

/**
 2.Subjects 既是订阅者，也是 Observable
 PublishSubject、BehaviorSubject、ReplaySubject、Variable
 
 PublishSubject 是最普通的 Subject，它不需要初始值就能创建
 PublishSubject 的订阅者从他们开始订阅的时间点起，可以收到订阅后 Subject 发出的新 Event，而不会收到他们在订阅前已发出的 Event
 
 BehaviorSubject 需要通过一个默认初始值来创建。 可替代（Variable 之后的版本已经废弃）
 当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的 event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event
 
 ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
 比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个 .next 的 event。
 如果一个 subscriber 订阅已经结束的 ReplaySubject，除了会收到缓存的 .next 的 event 外，还会收到那个终结的 .error 或者 .complete 的 event
 
 
 */

import UIKit

class Subjects2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
