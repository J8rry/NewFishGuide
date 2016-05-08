//
//  JKADViewController.m
//  BuDeJie
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "JKADItem.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "JKTabBarController.h"


@interface JKADViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *LauchImageView;  // 公司LOGO
@property (weak, nonatomic) IBOutlet UIView *ADView;    // 广告图片 占70%比例
@property (weak, nonatomic) IBOutlet UIButton *JumpBtn; // 跳过按钮

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) JKADItem *item;
@property (nonatomic, weak) NSTimer *timer;

@end

// 阅读接口文档 测试获取(w_picurl, ori_curl, w:480 h:800)

#define JKCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@implementation JKADViewController

- (UIImageView *)imageView
{
    if (_imageView == nil) {
       UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.ADView addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置启动画面 (根据不同屏幕适配)
    [self setUpLauchImage];
    
    // 加载广告数据
    [self loadData];
    
    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}

- (IBAction)jumpClick:(id)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[JKTabBarController alloc] init];
    
    // 还要销毁定时器
    [self.timer invalidate];
}

- (void)tap
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:self.item.ori_curl]]) {
        [app openURL:[NSURL URLWithString:self.item.ori_curl]];
    }
}

- (void)timeChange
{
    static int i = 3;
    
    if (i <= 0) {
        [self jumpClick:nil];
    }
    
    i--;
    
    NSString *str = [NSString stringWithFormat:@"跳过 (%d)", i];
    [self.JumpBtn setTitle:str forState:UIControlStateNormal];
    
}

- (void)loadData
{
    // 发送网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = JKCode2;
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 解析数据 -> 写成plist文件 -> 字典转模型 -> 模型数据展示界面
        // 获取字典
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        
        // 字典转模型
         self.item = [JKADItem mj_objectWithKeyValues:adDict];
        
        if (self.item.w <= 0) return;
        
        CGFloat w = JKUIScreenW;
        CGFloat h = JKUIScreenW / _item.w * _item.h;
        self.imageView.frame = CGRectMake(0, 0, w, h);
        
        // 加载广告图片
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.item.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

- (void)setUpLauchImage
{
    UIImage *image = nil;
    if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if(iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if(iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if(iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    self.LauchImageView.image = image;
}

@end
