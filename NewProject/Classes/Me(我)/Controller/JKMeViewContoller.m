//
//  JKMeViewContoller.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKMeViewContoller.h"

@implementation JKMeViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setupNavBar]; // 设置导航条内容
    
}

- (void)setupNavBar
{
    // 右边
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    // 中间 titleView
    self.navigationItem.title = @"我的";
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)setting
{
    
}


@end
