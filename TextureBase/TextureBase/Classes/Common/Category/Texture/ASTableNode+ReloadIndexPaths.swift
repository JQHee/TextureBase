//
//  ASTableNode+ReloadIndexPaths.swift
//  TextureBase
//
//  Created by midland on 2018/12/12.
//  Copyright © 2018年 ml. All rights reserved.
//

import Foundation

fileprivate struct BFRefreshRuntimeKey {
    static let tnReloadIndexPathsKey = UnsafeRawPointer.init(bitPattern: "tnReloadIndexPathsKey".hashValue)
    static let cnReloadIndexPathsKey = UnsafeRawPointer.init(bitPattern: "cnReloadIndexPathsKey".hashValue)
}

extension ASTableNode {
    
    var tn_reloadIndexPaths: [IndexPath]? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.tnReloadIndexPathsKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, BFRefreshRuntimeKey.tnReloadIndexPathsKey!) as? [IndexPath]
        }
    }
}

extension ASCollectionNode {
    var cn_reloadIndexPaths: [IndexPath]? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.cnReloadIndexPathsKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, BFRefreshRuntimeKey.cnReloadIndexPathsKey!) as? [IndexPath]
        }
    }
}

/* 可视cell刷新
 _tableNode.js_reloadIndexPaths = _tableNode.indexPathsForVisibleRows()
 [self.tableNode reloadData];
 */

/* 单个cell 刷新
_tableNode.js_reloadIndexPaths = @[indexPath];
[_tableNode reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
 */

/* ASTableNode reloadData 动画很奇怪，不想要动画
 可以用 tableNode.performBatchUpdates(nil, completion: nil) [等同于 tableNode.beginUpdate & tableNode.endUpdate] 替代 tableNode.reloadData()
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

/*
private var indexPathesToBeReloaded: [IndexPath] = []

func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
    let cell = ASCellNode()
        ... // 其他代码

        cell.neverShowPlaceholders = false
    if indexPathesToBeReloaded.contains(indexPath) {
        let oldCellNode = tableNode.nodeForRow(at: indexPath)
        cell.neverShowPlaceholders = true
        oldCellNode?.neverShowPlaceholders = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            cell.neverShowPlaceholders = false
            if let indexP = self.indexPathesToBeReloaded.index(of: indexPath) {
                self.indexPathesToBeReloaded.remove(at: indexP)
            }
        })
    }
    return cell
}
*/
