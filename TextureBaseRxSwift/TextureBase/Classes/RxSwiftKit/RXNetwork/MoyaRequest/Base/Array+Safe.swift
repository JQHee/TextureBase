//
//  Array+Safe.swift
//  TextureBase
//
//  Created by midland on 2019/1/7.
//  Copyright © 2019年 ml. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
}
