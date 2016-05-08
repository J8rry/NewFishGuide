//
//  JKFriendTrendViewController.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKFriendTrendViewController.h"

@implementation JKFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setupNavBar]; // 设置导航条内容

}

- (void)setupNavBar
{
    // 左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 中间 titleView
    self.navigationItem.title = @"我的关注";
}

- (void)friendsRecomment
{
    
}


@end
