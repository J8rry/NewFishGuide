//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by Jerry on 16/4/2.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(CGFloat)jk_width
{
    return self.frame.size.width;
}

- (void)setJk_width:(CGFloat)jk_width
{
    CGRect frame = self.frame;
    frame.size.width = jk_width;
    self.frame = frame;
}

-(CGFloat)jk_height
{
    return self.frame.size.height;
}

- (void)setJk_height:(CGFloat)jk_height
{
    CGRect frame = self.frame;
    frame.size.height = jk_height;
    self.frame = frame;
}

- (CGFloat)jk_x
{
    return self.frame.origin.x;
}

- (void)setJk_x:(CGFloat)jk_x
{
    CGRect frame = self.frame;
    frame.origin.x = jk_x;
    self.frame = frame;

}

- (CGFloat)jk_y
{
    return self.frame.origin.y;
}

- (void)setJk_y:(CGFloat)jk_y
{
    CGRect frame = self.frame;
    frame.origin.y = jk_y;
    self.frame = frame;

}

- (CGFloat)jk_centerX
{
    return self.center.x;
}

-(void)setJk_centerX:(CGFloat)jk_centerX
{
    CGPoint center = self.center;
    center.x = jk_centerX;
    self.center = center;
}

- (CGFloat)jk_centerY
{
    return self.center.y;
}

-(void)setJk_centerY:(CGFloat)jk_centerY
{
    CGPoint center = self.center;
    center.y = jk_centerY;
    self.center = center;
}

+ (instancetype)jk_viewFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
