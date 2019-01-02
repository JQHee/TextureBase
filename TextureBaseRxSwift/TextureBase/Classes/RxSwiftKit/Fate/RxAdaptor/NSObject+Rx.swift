//
//  NSObject+Rx.swift
//  Fate
//
//  Created by Archer on 2018/11/23.
//

import RxSwift

/// Equivalent to @synchronized(key) {} in Objective-C.
public func synchronized<_Tp>(_ key: Any, execute: () -> _Tp) -> _Tp {
    objc_sync_enter(key)
    let result = execute()
    objc_sync_exit(key)
    return result
}

extension NSObject {
    
    /// 以类型推断的形式浅拷贝一个对象
    public func clone<_Tp: NSCopying>(_ objectClass: _Tp.Type = _Tp.self) -> _Tp? {
        return self.copy() as? _Tp
    }
    
    /// 以类型推断的形式深拷贝一个对象
    public func mutableClone<_Tp: NSMutableCopying>(_ objectClass: _Tp.Type = _Tp.self) -> _Tp? {
        return self.mutableCopy() as? _Tp
    }
}

/*
fileprivate var disposeBagKey: UInt8 = 0

public extension NSObject {
    /// Provide a unique disposeBag for NSObject subclass.
    public var disposeBag: DisposeBag {
        set {
            synchronized(self) {
                objc_setAssociatedObject(self, &disposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get {
            return synchronized(self) {
                if let disposeObject = objc_getAssociatedObject(self, &disposeBagKey) as? DisposeBag {
                    return disposeObject
                }
                let disposeObject = DisposeBag()
                objc_setAssociatedObject(self, &disposeBagKey, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObject
            }
        }
    }
}
 */
