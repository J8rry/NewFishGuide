//
//  UIBarButtonItem+Item.h
//  BuDeJie
//
//  Created by Jerry on 16/4/2.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+(instancetype)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;

+(instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)highImage target:(id)target action:(SEL)action;



@end
