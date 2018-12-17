//
//  UIImage+TYLaunchImage.h
//  TYLaunchAnimationDemo
//
//  Created by tanyang on 15/12/3.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 适用于Assets中配置有启动图的情况 */
@interface UIImage (TYLaunchImage)

+ (NSString *)ty_getLaunchImageName;

+ (UIImage *)ty_getLaunchImage;

@end
