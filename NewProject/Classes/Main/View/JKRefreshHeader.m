//
//  JKRefreshHeader.m
//  NewProject
//
//  Created by Jerry on 16/5/11.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKRefreshHeader.h"

@implementation JKRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.automaticallyChangeAlpha = YES;
        self.stateLabel.font = [UIFont systemFontOfSize:16];
        self.stateLabel.textColor = [UIColor orangeColor];
        self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
        [self setTitle:@"🐴上往下拉吧" forState:MJRefreshStateIdle];
        [self setTitle:@"松开🐴上刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在拼命刷新..." forState:MJRefreshStateRefreshing];
    }
    return self;
}

@end
