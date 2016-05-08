//
//  JKSubTagCell.m
//  BuDeJie
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKSubTagCell.h"
#import "JKSubTagItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Render.h"

@interface JKSubTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *subTagNum;

@end

@implementation JKSubTagCell

- (void)setItem:(JKSubTagItem *)item
{
    _item = item;
    // 1. 头像
    // 1.1 占位图 矩形圆角
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] getRoundedRectImage];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        
        self.iconImageView.image = [image getRoundedRectImage];
    
    }];
    // 2.姓名
    self.titleName.text = item.theme_name;
    
    // 3.订阅数量
    NSString *str = [NSString stringWithFormat:@"%@人订阅", item.sub_number];
    int num = str.intValue;
    
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        str = [NSString stringWithFormat:@"%.1f人订阅", numF];
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    self.subTagNum.text = str;
    
}



- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 设置分隔线的间距 留出1的空隙 显示view背景色
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
