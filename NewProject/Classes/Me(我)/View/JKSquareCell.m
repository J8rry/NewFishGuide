//
//  JKSquareCell.m
//  BuDeJie
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKSquareCell.h"
#import "JKSquareItem.h"
#import <UIImageView+WebCache.h>

@interface JKSquareCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *labelView;


@end

@implementation JKSquareCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(JKSquareItem *)item
{
    _item = item;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _labelView.text = item.name;

}

@end
