//
//  MineViewController.m
//  BuDeJie
//
//  Created by Jerry on 16/3/31.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKMeViewController.h"
#import "JKSettingViewController.h"
#import "JKSquareCell.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import "JKSquareItem.h"
#import <SafariServices/SafariServices.h>
#import "JKWebViewController.h"

static NSString * const ID = @"cell";
static CGFloat const margin = 1;
static NSInteger const cols = 4;
#define itemWH (JKUIScreenW - ((cols - 1) * margin)) / cols

@interface JKMeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation JKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setUpNavBar];
    
    // 设置footView
    [self setUpFootView];
    
    // 加载数据
    [self setUpData];
    
    // 设置tableView组间距
    // 如果是分组样式,默认每一句都会有头部和尾部间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

#pragma mark - 设置界面
// 设置底部视图
- (void)setUpFootView
{
    // 布置流水
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.minimumLineSpacing = margin;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    _collectionView = collectionView;
    
    collectionView.backgroundColor = JKColor(215, 215, 215);
    collectionView.scrollsToTop = NO;
    
    self.tableView.tableFooterView = collectionView;
    
    // 设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"JKSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

// 加载数据
- (void)setUpData
{
    // 发送请求 -> 查看接口文档 -> AFN
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"square_list"];
        self.squareItems = [JKSquareItem mj_objectArrayWithKeyValuesArray:array];
        
        // 处理数据
        [self resolveData];
        // 刷新列表
        [self.collectionView reloadData];
        
        // 计算collectionView的高度  万能公式 row = (count - 1) / cols + 1
        NSInteger count = self.squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        CGFloat collectionH = rows * itemWH + (rows -1) * margin + 2 * margin;
        self.collectionView.jk_height = collectionH;
        self.collectionView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
        
        // tableView的滚动范围是系统自动根据内容去计算
        self.tableView.tableFooterView = self.collectionView;
        // 重新计算contentSize
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

// 算出需要填补成白色的squareCell
- (void)resolveData
{
    NSInteger count = self.squareItems.count;
    NSInteger extre = count % cols;
    if (extre) { // 补模型
        extre = cols - extre;
        for (int i = 0; i < extre; i++) {
            JKSquareItem *item = [[JKSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}


- (void)setUpNavBar
{
    // 右边
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    
    
    // 中间 titleView
    self.navigationItem.title = @"我的";
}

// 夜间模式按钮选中状态
- (void)night:(UIButton *)btn
{
    btn.selected = !btn.selected;
}


// 设置按钮
- (void)setting
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"JKSettingViewController" bundle:nil];
    
    JKSettingViewController *settingVC = [[JKSettingViewController alloc] init];
    // 在push之前设置隐藏bottomBar属性
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareItems[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKSquareItem *item = self.squareItems[indexPath.row];
    
    if (![item.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:item.url];
    
    JKWebViewController *webVc = [[JKWebViewController alloc] init];
    webVc.url = url;
    
    [self.navigationController pushViewController:webVc animated:YES];
    
    // iOS9 之后可以使用SFSafari
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:YES];
//        
//    [self presentViewController:safariVC animated:YES completion:nil];
    
        
}

@end
