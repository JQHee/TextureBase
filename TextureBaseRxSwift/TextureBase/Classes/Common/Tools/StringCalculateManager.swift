//
//  StringCalculateManager.swift
//  TextureBase
//
//  Created by HJQ on 2019/1/7.
//  Copyright © 2019 ml. All rights reserved.
//

import Foundation
import UIKit

class StringCalculateManager {
    static let shared = StringCalculateManager()
    //fontDictionary是一个Dictionary，例如{".SFUIText-Semibold-16.0": {"0":10.3203125, "Z":10.4140625, "中":16.32, "singleLineHeight":19.09375}}，
    //fontDictionary的key是以字体的名字和大小拼接的String，例如".SFUIText-Semibold-16.0"
    //fontDictionary的value是一个Dictionary，存储对应字体的各种字符对应的宽度及字体的单行高度，例如{"0":10.3203125, "Z":10.4140625, "中":16.32, "singleLineHeight":19.09375}
    var fontDictionary = [String: [String: CGFloat]]()
    var numsNeedToSave = 0//更新的数据的条数
    var fileUrl: URL = {//fontDictionary在磁盘中的存储路径
        let manager = FileManager.default
        var filePath = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        filePath!.appendPathComponent("font_dictionary.json")
        print("font_dictionary.json的路径是===\(filePath!)")
        return filePath!
    }()

    init() {
        readFontDictionaryFromDisk()
        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: UIApplication.willTerminateNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //第一次使用字体时预先计算该字体中各种字符的宽度
    func createNewFont(font: UIFont) -> [String: CGFloat] {
        let array: [String] = ["中", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",  "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e",  "f",  "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "“", ";", "？", ",", "［", "]", "、", "【", "】", "?", "!", ":", "|"]
        var widthDictionary = [String: CGFloat]()
        var singleWordRect = CGRect.zero
        for string in array {
            singleWordRect = string.boundingRect(with: CGSize(width: 100, height: 100),
                                                 options: .usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: font],
                                                 context: nil)
            widthDictionary[string] = singleWordRect.size.width
        }
        widthDictionary["singleLineHeight"] = singleWordRect.size.height
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        fontDictionary[fontKey] = widthDictionary
        numsNeedToSave = array.count//代表有更新，需要存入到磁盘
        saveFontDictionaryToDisk()//存入本地json
        return widthDictionary
    }
    //限定最大行数的场景下计算Label的bounds
    func calculateSize(withString string: String, maxWidth: CGFloat, font: UIFont, maxLine: Int) -> CGRect {
        let totalWidth: CGFloat = calculateTotalWidth(string: string, font: font)
        var widthDictionary = fetchWidthDictionaryWith(font)
        let singleLineHeight = widthDictionary["singleLineHeight"]!
        let numsOfLine = ceil(totalWidth/maxWidth)//行数
        let maxLineCGFloat = CGFloat(maxLine)//最大
        let resultwidth = numsOfLine <= 1 ? totalWidth : maxWidth//小于最大宽度时，取实际宽度的值
        let resultLine = numsOfLine < maxLineCGFloat ? numsOfLine : maxLineCGFloat
        return CGRect.init(x: 0, y: 0, width: resultwidth, height: resultLine * singleLineHeight)
    }

    //行数不限的场景下计算Label的bounds
    func calculateSize(withString string: String, maxWidth: CGFloat, font: UIFont) -> CGRect {
        let totalWidth: CGFloat = calculateTotalWidth(string: string, font: font)
        var widthDictionary = fetchWidthDictionaryWith(font)
        let singleLineHeight = widthDictionary["singleLineHeight"]!
        let numsOfLine = ceil(totalWidth/maxWidth)//行数
        let resultwidth = numsOfLine <= 1 ? totalWidth : maxWidth//小于最大宽度时，取实际宽度的值
        return CGRect.init(x: 0, y: 0, width: resultwidth, height: numsOfLine * singleLineHeight)
    }

    //限定最大高度的场景下计算Label的bounds
    func calculateSize(withString string: String, maxSize: CGSize, font: UIFont) -> CGRect {
        let totalWidth: CGFloat = calculateTotalWidth(string: string, font: font)
        var widthDictionary = fetchWidthDictionaryWith(font)
        let singleLineHeight = widthDictionary["singleLineHeight"]!
        let numsOfLine = ceil(totalWidth/maxSize.width)//行数
        let maxLineCGFloat = floor(maxSize.height/singleLineHeight)
        let resultwidth = numsOfLine <= 1 ? totalWidth : maxSize.width//小于最大宽度时，取实际宽度的值
        let resultLine = numsOfLine < maxLineCGFloat ? numsOfLine : maxLineCGFloat
        return CGRect.init(x: 0, y: 0, width: resultwidth, height: resultLine * singleLineHeight)
    }

    //计算排版在一行的总宽度
    func calculateTotalWidth(string: String, font: UIFont) -> CGFloat {
        var totalWidth: CGFloat = 0
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        var widthDictionary = fetchWidthDictionaryWith(font)
        let chineseWidth = widthDictionary["中"]!
        for character in string {
            if "\u{4E00}" <= character  && character <= "\u{9FA5}" {//中文
                totalWidth += chineseWidth
            } else if let width = widthDictionary[String(character)]  {//数字，小写字母，大写字母，及常见符号
                totalWidth += width
            } else {//符号及其他没有预先计算好的字符，对它们进行计算并且缓存到宽度字典中去
                let tempString = String(character)
                let width = tempString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: [NSAttributedString.Key.font: font],
                                                    context: nil).size.width
                totalWidth += width
                widthDictionary[tempString] = width
                numsNeedToSave += 1
            }
        }
        fontDictionary[fontKey] = widthDictionary
        if numsNeedToSave > 10 {
            saveFontDictionaryToDisk()
        }
        return totalWidth
    }

    //获取字体对应的宽度字典
    func fetchWidthDictionaryWith(_ font: UIFont) -> [String: CGFloat] {
        var widthDictionary = [String: CGFloat]()
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        if let dictionary =  StringCalculateManager.shared.fontDictionary[fontKey] {
            widthDictionary = dictionary
        } else {
            widthDictionary = StringCalculateManager.shared.createNewFont(font: font)
        }
        return widthDictionary
    }

    let queue = DispatchQueue(label: "com.StringCalculateManager.queue")
    //存储fontDictionary到磁盘
    @objc func saveFontDictionaryToDisk() {
        guard numsNeedToSave > 0 else {
            return
        }
        numsNeedToSave = 0
        queue.async {//防止多线程同时写入造成冲突
            do {
                var data: Data?
                if #available(iOS 11.0, *) {
                    data = try? JSONSerialization.data(withJSONObject: self.fontDictionary, options: .sortedKeys)
                } else {
                    data = try? JSONSerialization.data(withJSONObject: self.fontDictionary, options: .prettyPrinted)
                }
                try data?.write(to: self.fileUrl)
                print("font_dictionary存入磁盘,font_dictionary=\(self.fontDictionary)")
            }  catch {
                print("font_dictionary存储失败error=\(error)")
            }
        }
    }
    //从磁盘中读取缓存
    func readFontDictionaryFromDisk() {
        do {
            let data = try Data.init(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let dict = json as? [String: [String: CGFloat]] else {
                return
            }
            fontDictionary = dict
            print(fontDictionary)
            print("font_dictionarys读取成功,font_dictionarys=\(fontDictionary)")
        } catch {
            print("第一次运行时font_dictionary不存在或者读取失败")
        }
    }
}

extension String {
    //限制最大行数的场景下，计算Label的bounds
    func boundingRectFast(withMaxWidth width: CGFloat, font: UIFont, maxLine: Int) -> CGRect {
        let rect = StringCalculateManager.shared.calculateSize(withString: self, maxWidth: width, font: font, maxLine: maxLine)
        return rect
    }
    //行数不限的场景下，计算Label的bounds
    func boundingRectFast(withMaxWidth width: CGFloat, font: UIFont) -> CGRect {
        let rect = StringCalculateManager.shared.calculateSize(withString: self, maxWidth: width, font: font)
        return rect
    }

    //限定最大高度的场景下，计算Label的bounds
    func boundingRectFast(withMaxSize size: CGSize, font: UIFont) -> CGRect {
        let rect = StringCalculateManager.shared.calculateSize(withString: self, maxSize: size, font: font)
        return rect
    }
}

