//
//  JKNewViewContoller.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKNewViewContoller.h"

@implementation JKNewViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor brownColor];
    [self setupNavBar]; // 设置导航条内容

}

- (void)setupNavBar
{
    // 左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subTag)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 中间 titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)subTag
{
    JKLog(@"subTag")
}

@end
