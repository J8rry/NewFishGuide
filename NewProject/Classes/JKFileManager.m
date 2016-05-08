//
//  JKFileManager.m
//  BuDeJie
//
//  Created by Jerry on 16/4/7.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKFileManager.h"

@implementation JKFileManager

+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"filePath Error" reason:@"需要传入文件夹路径" userInfo:nil];
        [exception raise];
    }
    
    // 获取文件夹的下一级目录
    NSArray *subPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

+ (NSInteger)getDirectorySize:(NSString *)directoryPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"filePath Error" reason:@"需要传入文件夹路径" userInfo:nil];
        [exception raise];
    }
    
    // 获取文件夹下所有的文件
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    NSInteger totalSize = 0;
    for (NSString *subPath in subPaths) {
        // 拼接文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 排除文件夹
        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        // 隐藏文件
        if ([filePath containsString:@".DS"]) continue;
        
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        NSInteger size = [attr fileSize];
        
        totalSize += size;
    }
    
    return totalSize;

}

@end
