//
//  ADLaunchController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Kingfisher
import RxSwift
import RxCocoa

// MARK: - 广告视图
class ADLaunchController: ASViewController<ASDisplayNode> {
    
    @objc dynamic var message = "message"
    let dispseBag = DisposeBag()
    let button = UIButton()
    let testView = UIView()

    // MARK: - Life cycle
    init() {
        super.init(node: ASDisplayNode())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestData()
    }

    deinit {
        print("deinit")
    }
    
    // MARK: - RX
    private func testScheduled() {
        // 定时器
        Observable<Int>.interval(1.0, scheduler: MainScheduler.instance).subscribe(onNext: { [unowned self](value) in
            print(value)
            self.message.append("!")
            
        }).disposed(by: dispseBag)
    }
    
    private func testKVO() {
        /* KVO 监听 */
        self.rx.observeWeakly(String.self, "message").subscribe(onNext: { (value) in
            
        }).disposed(by: dispseBag)
        
        // 监听屏幕尺寸
        self.rx.observe(CGRect.self, "frame").subscribe(onNext: { (tempFrame) in
            
        }).disposed(by: dispseBag)
    }
    
    private func testEventResponse() {
        button.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { (_) in
            
        }).disposed(by: dispseBag)
        
        button.rx.tap.asDriver().drive(onNext: { (_) in
            
        }).disposed(by: dispseBag)
        
        // 手势点击事件
        let tap = UITapGestureRecognizer()
        testView.addGestureRecognizer(tap)
        tap.rx.event.subscribe(onNext: { (_) in
            
        }).disposed(by: dispseBag)
        
    }

    // MARK: - Private methods
    private func setupUI() {
        adLaunchView.skipButtonNode.isHidden = true
        adLaunchView.skipButtonNode.addTarget(self, action: #selector(skipButtonAction), forControlEvents: ASControlNodeEvent.touchUpInside)
        adLaunchView.frame = view.bounds
        node.addSubnode(adLaunchView)
    }

    private func scheduledTimer() {
        if let _ = timer {
            timer?.invalidate()
            timer = nil
        }
        adLaunchView.skipButtonNode.isHidden = false
        adLaunchView.skipButtonNode.setTitle("跳过广告 \(count)s", with: UIFont.systemFont(ofSize: 13), with: UIColor.white, for: UIControl.State.normal)
    
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
    
    }
    
    private func requestData() {
        let request = ADLaunchRequest()
        adLaunchVM.requestImg(r: request, successBlock: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.showADImageWithURL()

        }) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.dismissController()
        }
    }

    func showADImageWithURL() {
        if self.adLaunchVM.imgURL.count > 0 {
            guard let imageView = adLaunchView.adImageNode.view as? UIImageView else {
                dismissController()
                return
            }
            var options = [KingfisherOptionsInfoItem]()
            options.append(KingfisherOptionsInfoItem.forceRefresh)
            guard let imageURL = URL.init(string: self.adLaunchVM.imgURL) else {
                dismissController()
                return
            }
            imageView.kf.setImage(with: imageURL, placeholder: nil, options:options , progressBlock: { (_, _) in

            }) { [weak self](image, error, cacheType, url) in
                guard let `self` = self else {
                    return
                }
                self.scheduledTimer()
            }

        } else {
            dismissController()
        }
    }

    func dismissController() {
        if let _ = timer {
            timer?.invalidate()
            timer = nil
        }
        UIView.animate(withDuration: 0.8, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            self.view.alpha = 0
            self.view.layoutIfNeeded()
        }) { (finish) in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }

    }

    // MARK: - Event response
    @objc
    func skipButtonAction() {
        dismissController()
    }

    @objc
    func timeCount() {
        count -= 1
        if count > 0 {
            adLaunchView.skipButtonNode.setTitle("跳过广告 \(count)s", with: UIFont.systemFont(ofSize: 13), with: UIColor.white, for: UIControl.State.normal)
        }
        if count == 0 {
            dismissController()
        }
    }

    // MARK: - Lazy load
    private lazy var adLaunchView: ADLaunchView = ADLaunchView()
    private lazy var adLaunchVM: ADLaunchViewModel = ADLaunchViewModel()
    private var timer: Timer?
    var count: Int = 3

}
