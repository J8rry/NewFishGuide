//
//  JKEssenceViewController.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKEssenceViewController.h"

@interface JKEssenceViewController()

@end

@implementation JKEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setUpNav]; // 设置导航条内容
}

- (void)setUpNav
{
    // 左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 右边
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 中间 titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)game
{
    JKLog(@"game")
}

@end
