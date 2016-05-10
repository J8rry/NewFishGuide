//
//  JKEssenceViewController.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKEssenceViewController.h"
#import "JKAllViewController.h"
#import "JKVedioViewController.h"
#import "JKPictureViewController.h"
#import "JKVoiceViewController.h"
#import "JKWordViewController.h"
#import "JKTitlesButton.h"

@interface JKEssenceViewController()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *titlesView; // 标题View
@property (nonatomic, weak) JKTitlesButton *preSelectedButton; // 前一个被选中的按钮
@property (nonatomic, weak) UIView *titleUnderLine; // 下划线

@end

@implementation JKEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpAllChildViewController]; // 初始化子控制器

    [self setUpNav]; // 设置导航条内容
    
    [self setUpScrollView];  // 添加ScrollView

    [self setUpTitlesView];  // 标题栏

    [self addChildViewIntoScrollView:0]; // 默认选中
}

- (void)setUpAllChildViewController
{
    [self addChildViewController:[[JKAllViewController alloc] init]];
    [self addChildViewController:[[JKVedioViewController alloc] init]];
    [self addChildViewController:[[JKPictureViewController alloc] init]];
    [self addChildViewController:[[JKVoiceViewController alloc] init]];
    [self addChildViewController:[[JKWordViewController alloc] init]];
}

/**
 *  设置ScrollView
 */
- (void)setUpScrollView
{
    // 不要去自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = JKRandomColor;
    scrollView.delegate = self;
    
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    NSInteger count = self.childViewControllers.count;
    
    scrollView.scrollsToTop = NO;
    scrollView.contentSize = CGSizeMake(self.view.jk_width * count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
}


/**
 *  添加标题栏
 */
- (void)setUpTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, 64, self.view.jk_width, JKTitlesViewH);
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    
    // 标题
    [self setUpTitlesButton];
    // 下划线
    [self setUptitleUnderLine];
}


/**
 *  添加标题栏里的按钮
 */
- (void)setUpTitlesButton
{
    NSArray *titles = @[@"全部", @"视频", @"图片", @"声音", @"段子"];
    NSInteger count = titles.count;
    CGFloat titlesButtonW = self.titlesView.jk_width / count;
    CGFloat titlesButtonH = self.titlesView.jk_height;
    for (int i = 0; i < count; i++) {
        JKTitlesButton *titlesButton = [[JKTitlesButton alloc] init];
        titlesButton.tag = i;
        
        [titlesButton setTitle:titles[i] forState:UIControlStateNormal];
        [titlesButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        titlesButton.frame = CGRectMake(i * titlesButtonW, 0, titlesButtonW, titlesButtonH);
        [titlesButton addTarget:self action:@selector(titlesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titlesButton];
        
    }
}

/**
 *  添加标题栏里按钮下划线
 */
- (void)setUptitleUnderLine
{
    // 取出标题按钮
    JKTitlesButton *firstButton = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderLine = [[UIView alloc] init];
    titleUnderLine.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    CGFloat titleUnderLineH = 2;
    CGFloat titleUnderLineY = self.titlesView.jk_height - titleUnderLineH;
    titleUnderLine.frame = CGRectMake(0, titleUnderLineY, 0, titleUnderLineH);
    [self.titlesView addSubview:titleUnderLine];
    self.titleUnderLine = titleUnderLine;
    
    // 新点击的按钮 -> 红色
    firstButton.selected = YES;
    self.preSelectedButton = firstButton;
    
    // 下划线
    [firstButton.titleLabel sizeToFit];
    self.titleUnderLine.jk_width = firstButton.titleLabel.jk_width;
    self.titleUnderLine.jk_centerX = firstButton.jk_centerX;
    
}

#pragma mark - 监听点击

- (void)titlesButtonClick:(JKTitlesButton *)titlesButton
{
    if (self.preSelectedButton == titlesButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:titlesButtonDidReapeatClickNotification object:nil];
    }
    
    // 上一个点击的按钮 -> 暗灰色
    self.preSelectedButton.selected = NO;
    // 新点击的按钮 -> 红色
    titlesButton.selected = YES;
    self.preSelectedButton = titlesButton;
    
    NSInteger index = titlesButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 下划线
        self.titleUnderLine.jk_width = titlesButton.titleLabel.jk_width;
        self.titleUnderLine.jk_centerX = self.preSelectedButton.jk_centerX;
        
        // 滑动scrollView到对应的子控制器界面
        self.scrollView.contentOffset = CGPointMake(index * self.scrollView.jk_width, 0);
        
    }completion:^(BOOL finished) {
        [self addChildViewIntoScrollView:index];
    }];

    // 控制scrollView的scrollsToTop属性
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        
        // 如果控制器的view没有被创建, 跳过
        if (!childVC.isViewLoaded) continue;
        
        // 如果控制器的view不是scrollView, 就跳过
        if (![childVC.view isKindOfClass:[UIScrollView class]]) continue;
        
        // 如果控制器的view是scrollView
        UIScrollView *scrollView = (UIScrollView *)childVC.view;
        scrollView.scrollsToTop = (i == index);
    }
    
}

/**
 *  添加子控制器的view到scrollView当中: 利用懒加载 点击到了对应的标题 才加载view
 */
- (void)addChildViewIntoScrollView:(NSInteger)index
{
    UIViewController *childView = self.childViewControllers[index];
    if ([childView isViewLoaded]) return;
    childView.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childView.view];
}

#pragma -mark <UIScrollViewDelegate>
/**
 *  ScrollView滑动完毕的时候调用(速度减为0的时候调用)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.jk_width;
    JKTitlesButton *titlesButton = self.titlesView.subviews[index];
    
    // 如果scrollView向左侧滑动的时候, 返回后由于惯性 会弹回来 就会调用这个方法 用此解决BUG
    if (self.preSelectedButton == titlesButton) return;
    
    [self titlesButtonClick:titlesButton];

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
