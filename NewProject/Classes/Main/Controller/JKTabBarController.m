//
//  JKTabBarController.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTabBarController.h"

#import "JKEssenceViewController.h"
#import "JKNewViewContoller.h"
#import "JKPublishViewController.h"
#import "JKFriendTrendViewController.h"
#import "JKMeViewContoller.h"

#import "UIImage+Render.h"

@interface JKTabBarController()

@end


@implementation JKTabBarController

+ (void)load
{
    // 设置所有item的选中时颜色
    UITabBarItem *tarBarItem = [UITabBarItem appearance];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [tarBarItem setTitleTextAttributes:attr forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpAllChildViewController]; // 设置所有的子控制器
    
    [self setUpAllTitleButton]; // 设置tabBar上对应的按钮内容
}

- (void)setUpAllChildViewController
{
    // 精华
    JKEssenceViewController *essenVC = [[JKEssenceViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:essenVC];
    [self addChildViewController:nav1];
    
    // 新帖
    JKNewViewContoller *newVC = [[JKNewViewContoller alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav2];
    
    // 发布
    JKPublishViewController *publishVC = [[JKPublishViewController alloc] init];
    [self addChildViewController:publishVC];
    
    // 关注
    JKFriendTrendViewController *friendVC = [[JKFriendTrendViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:friendVC];
    [self addChildViewController:nav3];
    
    // 我
    JKMeViewContoller *meVC = [[JKMeViewContoller alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:nav4];
    
}

- (void)setUpAllTitleButton
{
    UINavigationController *nav1 = self.childViewControllers[0];
    nav1.tabBarItem.title = @"精华";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_new_click_icon"];
    
    UINavigationController *nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"新帖";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_new_click_icon"];
    
    JKPublishViewController *publish = self.childViewControllers[2];
    publish.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
    publish.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_publish_click_icon"];
    
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController *nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_me_click_icon"];
    
    
}

@end
