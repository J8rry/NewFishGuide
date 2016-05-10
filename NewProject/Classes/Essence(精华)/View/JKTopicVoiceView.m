//
//  JKTopicVoiceView.m
//  BuDeJie
//
//  Created by Jerry on 16/4/15.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTopicVoiceView.h"
#import "JKTopicsItem.h"
#import "JKSeeBigViewController.h"

@interface JKTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UIButton *voicePlayButton;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation JKTopicVoiceView

- (void)awakeFromNib
{
    self.voicePlayButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)];
    [self.voicePlayButton addGestureRecognizer:tap];
}


- (void)setTopics:(JKTopicsItem *)topics
{
    
    [self.voiceImageView jk_setImageWithOriginalImageURL:topics.image1 thumbnailImageURL:topics.image0];
    
    if ([topics.playcount integerValue] > 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放", [topics.playcount integerValue] / 10000.0];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%@播放", topics.playcount];
    }
    
    
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topics.voicetime.intValue / 60, topics.voicetime.intValue % 60];
}

- (void)seeBigPicture
{
    JKSeeBigViewController *seeBigVC = [[JKSeeBigViewController alloc] init];
    seeBigVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    seeBigVC.topics = self.topics;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigVC animated:YES completion:nil];
    
}


@end
