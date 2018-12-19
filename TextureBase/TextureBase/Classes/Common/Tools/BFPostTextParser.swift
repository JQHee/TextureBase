//
//  BFPostTextParser.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/19.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import TYAttributedLabel

class BFPostTextParser: NSObject {

    static func replaceXMLLabelWithText(text: NSString) -> String {
        var tempText = text.replacingOccurrences(of: "<br />", with: "\n")
        tempText = tempText.replacingOccurrences(of: "&nbsp;", with: " ")
        tempText = tempText.replacingOccurrences(of: "&nbsp", with: " ")
        tempText = tempText.replacingOccurrences(of: "<em>", with: "")
        tempText = tempText.replacingOccurrences(of: "</em>", with: "")
        tempText = tempText.replacingOccurrences(of: "\n\n>", with: "\n")
        tempText = tempText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return tempText as String
    }

    static func parserPostText(text: NSString) -> TYTextContainer {
        let textContainer = TYTextContainer()
        textContainer.font = UIFont.systemFont(ofSize: 16)
        textContainer.textColor = UIColor.init(red: 36/255.0, green: 36/255.0, blue: 36/255.0, alpha: 1.0)
        textContainer.text = text as String
        textContainer.addTextStorageArray(parseTextImageStorage(text: text) as? [Any])
        textContainer.createTextContainer(withTextWidth: kScreenW - 20)
        return textContainer
    }

    static func parseTextImageStorage(text: NSString) -> NSArray {

        if text.range(of: "img").location == NSNotFound && text.range(of: "IMG").location == NSNotFound {
            return NSArray()
        }

        let regex_image = "<(?i:img).+src=\"([^\"]+\\.(jpg|gif|bmp|bnp|png))\".*>"
        var imageStorageArray = [TYImageStorage]()
        let regular = try? NSRegularExpression.init(pattern: regex_image, options: NSRegularExpression.Options.caseInsensitive)
        guard let matches = regular?.matches(in: text as String, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange.init(location: 0, length: text.length)) else {
            return NSArray()
        }

        for (_, match) in matches.enumerated() {
            let range = match.range
            let imageURL = match.numberOfRanges > 1 ? text.substring(with: match.range(at: 1)) : text.substring(with: range)
            let imageStorage = TYImageStorage()
            imageStorage.range = range
            imageStorage.cacheImageOnMemory = true
            imageStorage.imageURL = URL.init(string: imageURL)
            imageStorage.size = CGSize.init(width: 32, height: 32)
            imageStorageArray.append(imageStorage)
        }

        return imageStorageArray as NSArray
    }

    static func sizeFitOriginSize(size: CGSize, width: CGFloat) -> CGSize{
        if size.width > width {
            let scale = width/size.width
            let height = size.height * scale
            return CGSize.init(width: width, height: height)
        }
        return CGSize.init(width: size.width, height: size.height)
    }

}
