//
//  JKLoginRegisterView.m
//  BuDeJie
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKLoginRegisterView.h"

@interface JKLoginRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;


@end

@implementation JKLoginRegisterView

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JKLoginRegisterView" owner:nil options:nil] firstObject];
}

+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JKLoginRegisterView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    UIImage *image = self.LoginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.LoginBtn setBackgroundImage:image forState:UIControlStateNormal];

}
@end
