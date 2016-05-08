//
//  JKTabBar.m
//  BuDeJie
//
//  Created by Jerry on 16/4/2.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTabBar.h"


@interface JKTabBar()

@property (nonatomic, weak) UIButton *publicBtn;

@property (nonatomic, weak) UIControl *previousClickTabBarButton;

@end

@implementation JKTabBar

- (UIButton *)publicBtn
{
    if (_publicBtn == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [btn sizeToFit];
        _publicBtn = btn;
        [self addSubview:_publicBtn];
        
    }
    return _publicBtn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.items.count + 1; // 注意加1
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.jk_width / count;
    CGFloat btnH = self.jk_height;
    
    int i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 0 && self.previousClickTabBarButton == nil) {
                self.previousClickTabBarButton = tabBarButton;
            }
            
            if (i == 2) {
                i += 1;
            }
            
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    
    // 设置加号按钮居中
//    self.publicBtn.center = self.center;
    self.publicBtn.center = CGPointMake(self.jk_width * 0.5, self.jk_height * 0.5);
    
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    if (self.previousClickTabBarButton == tabBarButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tabBarButtonDidRepeatClickNotification" object:nil userInfo:nil];
    }
    
    self.previousClickTabBarButton = tabBarButton;
}


@end
