//
//  JKTopicPictureView.m
//  BuDeJie
//
//  Created by Jerry on 16/4/15.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTopicPictureView.h"
#import "JKTopicsItem.h"
#import <UIImageView+WebCache.h>
#import "JKSeeBigViewController.h"



@interface JKTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (nonatomic, strong) JKTopicsItem *topic2;

@end

@implementation JKTopicPictureView

-(void)setTopics:(JKTopicsItem *)topics
{
    _topics = topics;
    
    [self.pictureImageView jk_setImageWithOriginalImageURL:topics.image1 thumbnailImageURL:topics.image0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        if (!topics.isBigPicture) return;
        
        CGFloat imageW = topics.viewFrame.size.width;
        CGFloat imageH = topics.viewFrame.size.height;
        
        UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
        
        [image drawInRect:CGRectMake(0, 0, imageW, imageW * topics.height / topics.width)];
        
        self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();

    }];
 
//    JKLog(@"pictuerTopic= %f", self.topics.height)
    self.gifImageView.hidden = !topics.is_gif;
    self.seeBigButton.hidden = !topics.isBigPicture;
    
}

- (void)awakeFromNib
{
    self.pictureImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)];
    [self.pictureImageView addGestureRecognizer:tap];
}

- (void)seeBigPicture
{
    JKSeeBigViewController *seeBigVC = [[JKSeeBigViewController alloc] init];
    seeBigVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    seeBigVC.topics = self.topics;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigVC animated:YES completion:nil];    
    
}

@end
