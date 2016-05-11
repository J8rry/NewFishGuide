//
//  JKAllViewController.m
//  BuDeJie
//
//  Created by Jerry on 16/4/9.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTopicViewController.h"
#import <AFNetworking.h>
#import "JKTopicsItem.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "JKTopicCell.h"
#import "JKRefreshHeader.h"
#import "JKRefreshFooter.h"

#import <SDImageCache.h>


@interface JKTopicViewController () 
/** 里面装着模型数组 */
@property (nonatomic, strong) NSMutableArray<JKTopicsItem *> *topics;
/** 上一次请求的maxtime */
@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, weak) AFHTTPSessionManager *manager;


@end

@implementation JKTopicViewController

-(JKTopicType)type
{
    return JKTopicTypeAll;
}

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString * const topicCell = @"topicCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = JKGlobeBgColor;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.contentInset = UIEdgeInsetsMake(JKNavBarBottomY + JKTitlesViewH , 0, JKTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 添加刷新控件
    [self setUpRefresh];
    
    // 监听通知
    [self setUpNotification];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JKTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCell];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titlesButtonDidRepeatClick) name:titlesButtonDidReapeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:tabBarButtonDidRepeatClickNotification object:nil];
}

- (void)tabBarButtonDidRepeatClick
{
    //    if (当前控制器的界面不在屏幕正中间)
    if (self.tableView.scrollsToTop == NO) return;
    
    // if (当前控制器的界面不在窗口上)
    if (self.tableView.window == nil) return;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)titlesButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

- (void)setUpRefresh
{
    // 广告
    UILabel *ad = [[UILabel alloc] init];
    ad.textColor = [UIColor whiteColor];
    ad.text = @"广告 广告 广告";
    ad.textAlignment = NSTextAlignmentCenter;
    ad.backgroundColor = [UIColor darkGrayColor];
    ad.jk_height = 35;
    self.tableView.tableHeaderView = ad;
    
    self.tableView.mj_header = [JKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新控件
    self.tableView.mj_footer = [JKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

#pragma mark - 数据
//   加载最新帖子的数据

- (void)loadNewTopics
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    [self.manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典数组 -> 转模型数组
        self.topics = [JKTopicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //        writePlistFileWithName(picture);
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        
        if (error.code == NSURLErrorCancelled) return;
        
        [SVProgressHUD showErrorWithStatus:@"网络出错, 请稍后尝试"];
    }];
}

- (void)loadMoreTopics
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    [self.manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典数组 -> 转模型数组
        NSArray *moreTopics = [JKTopicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JKLog(@"%@", error)
        
        [self.tableView.mj_footer endRefreshing];
        
        if (error.code == NSURLErrorCancelled) return;
        
        [SVProgressHUD showErrorWithStatus:@"网络出错, 请稍后尝试"];
        
    }];
    
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCell];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    // 处理header
    //    [self dealWithHeaderRefresh];
    //
    //    // 处理footer
    //    [self dealWithFooterRefresh];
    
    // 清楚内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
}



#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    // 正在刷新, 直接返回
//    if (self.headerRefreshing) return;
//    
//    // 当偏移量 <= offsetY 时, header就完全出现, 进去下拉刷新状态
//    CGFloat offsetY = -(self.tableView.contentInset.top + self.header.jk_height);
//    
//    if (self.tableView.contentOffset.y <= offsetY) {
//        
//        // 进去刷新状态
//        [self headerBeginRefreshing];
//    }
//    
//}


#pragma mark - header

//- (void)dealWithHeaderRefresh
//{
//    // 处理下拉刷新
//    if (self.headerRefreshing == YES) return;
//    if (self.header == nil) return;
//    
//    // 当偏移量 <= offsetY 时, header就完全出现, 进去下拉刷新状态
//    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.jk_height);
//    
//    if (self.tableView.contentOffset.y <= offsetY) {
//        self.header.text = @"松开加载数据";
//        self.header.backgroundColor = [UIColor purpleColor];
//    } else {
//        self.header.text = @"下拉加载更多数据";
//        self.header.backgroundColor = [UIColor redColor];
//    }
//    
//}



/** header进入刷新状态 */
//- (void)headerBeginRefreshing
//{
//    if (self.isHeaderRefreshing) return;
//    
//    self.headerRefreshing = YES;
//    self.header.text = @"正在加载数据...";
//    self.header.backgroundColor = [UIColor blueColor];
//    
//    // 增大内边距
//    [UIView animateWithDuration:0.25 animations:^{
//        UIEdgeInsets inset = self.tableView.contentInset;
//        inset.top += self.header.jk_height;
//        self.tableView.contentInset = inset;
//        
//        CGPoint offset = self.tableView.contentOffset;
//        offset.y = - inset.top;
//        self.tableView.contentOffset = offset;
//    }];
//    
//    // 发送请求给服务器
//    [self loadNewTopics];
//    
//    
//}

/** header结束刷新 */
//- (void)headerEndRefreshing
//{
//    self.headerRefreshing = NO;
//    
//    // 内边距
//    [UIView animateWithDuration:0.25 animations:^{
//        UIEdgeInsets inset = self.tableView.contentInset;
//        inset.top -= self.header.jk_height;
//        self.tableView.contentInset = inset;
//    }];
//    
//}

#pragma mark - footer

// 处理footer
//- (void)dealWithFooterRefresh
//{
//    // 如果还没有数据, 不需要处理footer
//    if (self.topics.count == 0) return;
//    
//    // 如果正在上拉刷新(加载更多的数据) , 直接返回
//    if (self.isFooterRefreshing) return;
//    
//    // 当偏移量 >= offsetY时, footer就完全出现, 进入上拉刷新状态
//    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.jk_height;
//    
//    if (self.tableView.contentOffset.y >= offsetY) {
//        // 进入刷新状态
//        [self footerBeginRefreshing];
//    }
//}


/** footer进入刷新状态 */
//- (void)footerBeginRefreshing
//{
//    if (self.isFooterRefreshing) return;
//    
//    self.footerRefreshing = YES;
//    self.footer.text = @"正在加载更多的数据";
//    self.footer.backgroundColor = [UIColor blueColor];
//    
//    // 发送请求给服务器, 加载更多的数据
//    [self loadMoreTopics];
//    
//}

/** footer结束刷新 */
//- (void)footerEndRefreshing
//{
//    self.footerRefreshing = NO;
//    self.footer.text = @"上拉加载更多的数据";
//    self.footer.backgroundColor = [UIColor redColor];
//}






@end
