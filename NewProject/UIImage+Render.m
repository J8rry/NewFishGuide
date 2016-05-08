//
//  UIImage+Render.m
//  BuDeJie
//
//  Copyright © 2016年 JK. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

+ (UIImage *)imageNameWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 返回一个没有渲染图片
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 返回一个带圆角矩形的图片
- (UIImage *)getRoundedRectImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:self.size.width * 0.1];
    
    // 添加裁剪
    [path addClip];
    
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = [[UIImage alloc] init];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
