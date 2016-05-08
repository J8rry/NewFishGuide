//
//  UITextField+Placeholder.m
//  BuDeJie
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

+(void)load
{
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setJK_PlaceholderMethod = class_getInstanceMethod(self, @selector(setJK_Placeholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, setJK_PlaceholderMethod);
}

- (void)setJK_Placeholder:(NSString *)placeholder
{
    // 设置占位文字
    [self setJK_Placeholder:placeholder];
    
    // 设置占位文字颜色
    [self setPlaceholderColor:self.placeholderColor];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 1. 把占位文字颜色先保存
//    objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
    
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 2. 等真正设置占位文字的时候, 再去设置颜色
    
    // 3. 获取占位文字控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    // 4. 拿控制去设置颜色
    placeholderLabel.textColor = placeholderColor;
    
}

// 返回占位文字颜色
- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

@end
