//
//  JKFriendTrendViewController.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKFriendTrendViewController.h"
#import "JKLoginViewController.h"

@implementation JKFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (IBAction)LoginClick {
    
    JKLoginViewController *jk = [[JKLoginViewController alloc] init];
    
    [self presentViewController:jk animated:YES completion:nil];
}

- (IBAction)RegisterClick {
    JKLoginViewController *registerVc = [[JKLoginViewController alloc] init];
    registerVc.isRegister = YES;
    [self presentViewController:registerVc animated:YES completion:nil];
}




@end
