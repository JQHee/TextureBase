//
//  InfomationViewController.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/14.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - 资讯
class InfomationViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "资讯"
        let test = UIImageView()
        test.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        view.addSubview(test)
        var options = [KingfisherOptionsInfoItem]()
        options.append(KingfisherOptionsInfoItem.forceRefresh)
        test.kf.setImage(with: URL.init(string: "http://iplay.nosdn.127.net/006sazpogmulhrhs31he1h3dr9u7ddvd.jpeg"), placeholder: nil, options:options , progressBlock: { (_, _) in

        }) {(image, error, cacheType, url) in
  
        }
    }

}
