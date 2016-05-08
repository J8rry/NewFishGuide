//
//  JKFileManager.h
//  BuDeJie
//
//  Created by Jerry on 16/4/7.
//  Copyright © 2016年 Jerry. All rights reserved.
//  专门用于处理文件业务

#import <Foundation/Foundation.h>

@interface JKFileManager : NSObject

/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getDirectorySize:(NSString *)directoryPath;


/**
 *  删除文件夹下所有文件
 *
 *  @param directoryPath 文件夹全路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
