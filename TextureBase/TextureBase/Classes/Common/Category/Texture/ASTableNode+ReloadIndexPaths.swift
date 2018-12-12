//
//  ASTableNode+ReloadIndexPaths.swift
//  TextureBase
//
//  Created by midland on 2018/12/12.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation

fileprivate struct BFRefreshRuntimeKey {
    static let reloadIndexPathsKey = UnsafeRawPointer.init(bitPattern: "reloadIndexPathsKey".hashValue)
}

extension ASTableNode {
    
    var js_reloadIndexPaths: NSArray? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.reloadIndexPathsKey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return  objc_getAssociatedObject(self, BFRefreshRuntimeKey.reloadIndexPathsKey!) as? NSArray
        }
    }
    
}

/* 可视cell刷新
 _tableNode.js_reloadIndexPaths = _tableNode.indexPathsForVisibleRows;
 [self.tableNode reloadData];
 */

/* 单个cell 刷新
_tableNode.js_reloadIndexPaths = @[indexPath];
[_tableNode reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
 */

/*
- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCellNode *(^ASCellNodeBlock)(void) = ^ASCellNode *() {
        ImageCellNode *cellNode = [[ImageCellNode alloc] initWithModel:_viewModel.dataArray[indexPath.row]];
        if ([tableNode.js_reloadIndexPaths containsObject:indexPath]) {
            cellNode.neverShowPlaceholders = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cellNode.neverShowPlaceholders = NO;
                });
        } else {
            // 该属性解决闪烁的问题
            cellNode.neverShowPlaceholders = NO;
        }
        return cellNode;
    };
    return ASCellNodeBlock;
}
 */
