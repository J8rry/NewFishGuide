//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by Jerry on 16/4/2.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat jk_width;
@property CGFloat jk_height;
@property CGFloat jk_x;
@property CGFloat jk_y;
@property CGFloat jk_centerX;
@property CGFloat jk_centerY;


+ (instancetype)jk_viewFromNib;


@end
