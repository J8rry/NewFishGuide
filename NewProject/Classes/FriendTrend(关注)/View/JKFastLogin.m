//
//  JKFastLogin.m
//  BuDeJie
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKFastLogin.h"

@implementation JKFastLogin

+(instancetype)fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JKFastLogin" owner:nil options:nil] lastObject];
}

@end
