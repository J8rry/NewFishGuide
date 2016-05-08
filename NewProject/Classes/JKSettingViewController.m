//
//  JKSettingViewController.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKSettingViewController.h"
#import "JKFileManager.h"
#import <SDImageCache.h>

#define cachePath  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]


static NSString * const ID = @"Cell";
@interface JKSettingViewController ()

@end

@implementation JKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [self getFileSizeStr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [JKFileManager removeDirectoryPath:cachePath];
    
    [self.tableView reloadData];
}

- (NSString *)getFileSizeStr
{
    // 获取Cache文件夹路径
    // b -> b / 1000 KB -> KB / 1000 MB
    // 获取文件夹尺寸
    NSInteger totalSize = [JKFileManager getDirectorySize:cachePath];
    
    NSString *str = @"清除缓存";
    if (totalSize > 1000 * 1000) { // MB
        CGFloat totalSizeF = totalSize / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fMB)",str,totalSizeF];
    } else if (totalSize > 1000) { // KB
        CGFloat totalSizeF = totalSize / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fKB)",str,totalSizeF];
    } else if (totalSize > 0) { // B
        str = [NSString stringWithFormat:@"%@(%ldB)",str,totalSize];
    }
    
    return str;
}



@end
