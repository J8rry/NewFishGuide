//
//  JKTopicsItem.m
//  BuDeJie
//
//  Created by Jerry on 16/4/12.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTopicsItem.h"

@implementation JKTopicsItem

- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
        
    // 正文的Y值
    _cellHeight += 55;
    
    CGSize maxSize = CGSizeMake(JKUIScreenW - 2 * JKMargin, MAXFLOAT);
    CGRect textSize = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    _cellHeight += textSize.size.height + JKMargin;
    
    if (self.type != JKTopicTypeWord) {
        
        CGFloat viewWidth = maxSize.width;
        CGFloat viewHeight = viewWidth * self.height / self.width;
        CGFloat viewX = JKMargin;
        CGFloat viewY = _cellHeight;
        
        if (self.height > JKUIScreenH) {
            viewHeight = JKUIScreenH * 0.3;
            self.BigPicture = YES;
            
        }
        
        self.viewFrame = CGRectMake(viewX, viewY, viewWidth, viewHeight);
            
        _cellHeight += viewHeight + JKMargin;
    }
    
    if (self.top_cmt.count){
        
        _cellHeight += 21;
        
        NSString *name = [self.top_cmt firstObject][@"user"][@"username"];
        NSString *content = [self.top_cmt firstObject][@"content"];
        if (content.length == 0) {
            content = @"[语言评论]";
        }

        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@", name, content];

    CGFloat height = [topCmtText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
        _cellHeight += height + JKMargin;
    
    }
    
    // 工具条高度
    _cellHeight += JKMargin + 35;
    
    return _cellHeight;
}

@end
