//
//  JKADItem.h
//  BuDeJie
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKADItem : NSObject
//w_picurl, ori_curl

@property (nonatomic, strong) NSString *w_picurl;
@property (nonatomic, strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end
