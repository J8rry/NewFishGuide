//
//  JKTopicVedioView.m
//  BuDeJie
//
//  Created by Jerry on 16/4/15.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTopicVedioView.h"
#import "JKTopicsItem.h"
#import "JKSeeBigViewController.h"


@interface JKTopicVedioView()

@property (weak, nonatomic) IBOutlet UIButton *vedioPlayButton;
@property (weak, nonatomic) IBOutlet UIImageView *vedioImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *vedioTimeLabel;

@end

@implementation JKTopicVedioView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.vedioImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)];
    [self.vedioImageView addGestureRecognizer:tap];
}


-(void)setTopics:(JKTopicsItem *)topics
{
    _topics = topics;
    
    [self.vedioImageView jk_setImageWithOriginalImageURL:topics.image1 thumbnailImageURL:topics.image0];
//    [self.vedioImageView sd_setImageWithURL:[NSURL URLWithString:topics.image1] placeholderImage:nil];
    
    if (topics.playcount > 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topics.playcount / 10000.0];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topics.playcount];
    }
    
    self.vedioTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topics.voicetime / 60, topics.voicetime % 60];
}

- (void)seeBigPicture
{
    JKSeeBigViewController *seeBigVC = [[JKSeeBigViewController alloc] init];
    seeBigVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    seeBigVC.topics = self.topics;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigVC animated:YES completion:nil];
    
}


@end
