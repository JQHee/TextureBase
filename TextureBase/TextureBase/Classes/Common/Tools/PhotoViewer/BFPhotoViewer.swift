//
//  MMLPhotoViewer.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/24.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

/*
 * 图片查看器
 * LPPhotoViewer 留存
 */

class BFPhotoViewer {
    
    static let shared = BFPhotoViewer()
    private  init() {}
    
    // 处理远程服务器的图片
    private var datas = [Any]()

    // 查看远程图片
    func viewRemoteImages(vc: UIViewController, datas: [Any], currentIndex: Int) {
        
        self.datas = datas
        let photoBrowser = YLPhotoBrowser.init(currentIndex, self)
        // 用白色 遮挡 原来的图
        photoBrowser.originalCoverViewBG = UIColor.white
        
        // 非矩形图片需要实现(比如聊天界面带三角形的图片) 默认是矩形图片
        photoBrowser.getTransitionImageView = { (currentIndex: Int,image: UIImage?, isBack: Bool) -> UIView? in
            return nil
        }
        vc.present(photoBrowser, animated: true, completion: nil)
    }
}

extension BFPhotoViewer: YLPhotoBrowserDelegate {
    func epPhotoBrowserGetPhotoCount() -> Int {
        return datas.count
    }
    
    func epPhotoBrowserGetPhotoByCurrentIndex(_ currentIndex: Int) -> YLPhoto {
        let photo = YLPhoto()
        let data = datas[currentIndex]
        if let image = data as? UIImage {
            photo.image = image
        }
        if let imageURL = data as? String {
            photo.imageUrl = imageURL
        }
        return photo
    }
    
}
