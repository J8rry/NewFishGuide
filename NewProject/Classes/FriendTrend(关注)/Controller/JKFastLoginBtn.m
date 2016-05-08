//
//  JKFastLoginBtn.m
//  BuDeJie
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKFastLoginBtn.h"

@implementation JKFastLoginBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.jk_centerX = self.jk_width * 0.5;
    self.imageView.jk_y = 0;

    [self.titleLabel sizeToFit];
    self.titleLabel.jk_centerX = self.jk_width * 0.5;
    self.titleLabel.jk_y = self.jk_height - self.titleLabel.jk_height;
}
@end
