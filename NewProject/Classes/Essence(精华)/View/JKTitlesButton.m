//
//  JKTitlesButton.m
//  BuDeJie
//
//  Created by Jerry on 16/4/9.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTitlesButton.h"

@interface JKTitlesButton()

@property (nonatomic, weak) JKTitlesButton *previousClickButton;

@end

@implementation JKTitlesButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
