//
//  JKTopicsItem.h
//  BuDeJie
//
//  Created by Jerry on 16/4/12.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKTopicsItem : NSObject

typedef NS_ENUM(NSInteger, JKTopicType){
    /** 全部 */
    JKTopicTypeAll = 1,
    /** 图片 */
    JKTopicTypePicture = 10,
    /** 文字 */
    JKTopicTypeWord = 29,
    /** 声音 */
    JKTopicTypeVoice = 31,
    /** 视频 */
    JKTopicTypeVideo = 41,
};

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 帖子的类型 */
@property (nonatomic, assign) NSInteger type;
/** 图片,视频的真实宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片,视频的真实高度 */
@property (nonatomic, assign) CGFloat height;
/** 是否是gif图片 */
@property (nonatomic, assign) BOOL is_gif;
/** 小图片 */
@property (nonatomic, strong) NSString *image0;
/** 大图片 */
@property (nonatomic, strong) NSString *image1;
/** 中图片 */
@property (nonatomic, strong) NSString *image2;
/** 播放数量 */
@property (nonatomic, strong) NSString *playcount;
/** 声音的文件长度 */
@property (nonatomic, strong) NSString *voicetime;
/** 视频的文件长度 */
@property (nonatomic, strong) NSString *videotime;






/** 为了开发方便, 创建的属性 */
/** 计算cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间View的frame */
@property (nonatomic, assign) CGRect viewFrame;
/** 是否是放大图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL BigPicture;



@end
