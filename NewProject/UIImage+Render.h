//
//  UIImage+Render.h
//  BuDeJie
//
//  Copyright © 2016年 JK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Render)
// 提供一个不要渲染图片方法
+ (UIImage *)imageNameWithOriginal:(NSString *)imageName;

// 返回一个带圆角矩形的图片
- (UIImage *)getRoundedRectImage;

@end
