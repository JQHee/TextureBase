//
//  PhotoEdgeIconCellNode.swift
//  TextureBase
//
//  Created by midland on 2018/12/14.
//  Copyright © 2018年 ml. All rights reserved.
//

/* 小红点
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASBackgroundLayoutSpec *badgeSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:_badgeTextNode background:_badgeImageNode];
    
    ASCornerLayoutSpec *cornerSpec1 = [ASCornerLayoutSpec cornerLayoutSpecWithChild:_photoNode1 corner:_dotNode location:ASCornerLayoutLocationTopRight];
    
    ASCornerLayoutSpec *cornerSpec2 = [ASCornerLayoutSpec cornerLayoutSpecWithChild:_photoNode2 corner:badgeSpec location:ASCornerLayoutLocationTopLeft];
    
    //super inherit
    self.photoNode.style.preferredSize = CGSizeMake(kSampleAvatarSize, kSampleAvatarSize);
    self.iconNode.style.preferredSize = CGSizeMake(kSampleIconSize, kSampleIconSize);
    ASCornerLayoutSpec *cornerSpec3 = [ASCornerLayoutSpec cornerLayoutSpecWithChild:self.photoNode corner:self.iconNode location:ASCornerLayoutLocationBottomLeft];
    
    ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    stackSpec.spacing = 40;
    stackSpec.children = @[cornerSpec1, cornerSpec2, cornerSpec3];
    
    return stackSpec;
}
*/
 
import UIKit
import AsyncDisplayKit

class PhotoEdgeIconCellNode: ASCellNode {
    
    override init() {
        super.init()
        setupUI()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        iconImageNode.style.preferredSize = CGSize.init(width: 40, height: 40)
        iconImageNode.style.layoutPosition = CGPoint.init(x: 150, y: 0)
        
        photoImageNode.style.preferredSize = CGSize.init(width: 150, height: 150)
        photoImageNode.style.layoutPosition = CGPoint.init(x: 20, y: 20)
        
        let absoluteLayoutSpec = ASAbsoluteLayoutSpec.init(sizing: ASAbsoluteLayoutSpecSizing.sizeToFit, children: [photoImageNode, iconImageNode])
        return absoluteLayoutSpec
    }

    // MARK: - Private methods
    private func setupUI() {
        addSubnode(photoImageNode)
        addSubnode(iconImageNode)
        
        photoImageNode.image = UIImage.init(named: "PhotoEdgeIcon.png")
    }
    
    // MARK: - Lazy load
    lazy var photoImageNode = ASImageNode()
    lazy var iconImageNode = ASImageNode()
}
