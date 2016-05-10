//
//  JKTopicCell.m
//  BuDeJie
//
//  Created by Jerry on 16/4/13.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTopicCell.h"
#import <UIImageView+WebCache.h>
#import "JKTopicsItem.h"

#import "JKTopicVedioView.h"
#import "JKTopicVoiceView.h"
#import "JKTopicPictureView.h"

@interface JKTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;

@property (nonatomic, strong) JKTopicVedioView *topicVedioView;
@property (nonatomic, strong) JKTopicVoiceView *topicVoiceView;
@property (nonatomic, strong) JKTopicPictureView *topicPictureView;


@end


@implementation JKTopicCell

-(JKTopicVedioView *)topicVedioView
{
    if (_topicVedioView == nil) {
        _topicVedioView = [JKTopicVedioView jk_viewFromNib];
        [self.contentView addSubview:_topicVedioView];
        
        
    }
    return _topicVedioView;
}

-(JKTopicVoiceView *)topicVoiceView
{
    if (_topicVoiceView == nil) {
        _topicVoiceView = [JKTopicVoiceView jk_viewFromNib];
        [self.contentView addSubview:_topicVoiceView];
        
    }
    return _topicVoiceView;
}

-(JKTopicPictureView *)topicPictureView
{
    if (_topicPictureView == nil) {
        _topicPictureView = [JKTopicPictureView jk_viewFromNib];
        [self.contentView addSubview:_topicPictureView];
        
    }
    return _topicPictureView;
}


- (void)awakeFromNib {
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}

- (void)setTopic:(JKTopicsItem *)topics
{
    _topic = topics;
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    self.nameLabel.text = topics.name;
    self.passtimeLabel.text = topics.passtime;
    self.text_label.text = topics.text;
    
    [self setUpButton:self.dingButton number:topics.ding placeholder:@"顶"];
    [self setUpButton:self.caiButton number:topics.cai placeholder:@"踩"];
    [self setUpButton:self.repostButton number:topics.repost placeholder:@"转发"];
    [self setUpButton:self.commentButton number:topics.comment placeholder:@"评论"];

    if (topics.top_cmt.count) { // 有最热评论
        self.topCommentView.hidden = NO;
        
        NSString *name = topics.top_cmt.firstObject[@"user"][@"username"];
        NSString *content = topics.top_cmt.firstObject[@"content"];
        if (content.length == 0) {
            content = @"[语言评论]";
        }
        
        self.topCommentLabel.text = [NSString stringWithFormat:@"%@ : %@", name, content];
    } else {
        self.topCommentView.hidden = YES;
    }
    
    switch (topics.type) {
        case JKTopicTypePicture: {
            self.topicPictureView.hidden = NO;
            self.topicPictureView.topics = topics;
            self.topicVedioView.hidden = YES;
            self.topicVoiceView.hidden = YES;
            break;
        }
        case JKTopicTypeVoice: {
            self.topicVoiceView.hidden = NO;
            self.topicVoiceView.topics = topics;
            self.topicVedioView.hidden = YES;
            self.topicPictureView.hidden = YES;
            break;
        }
        case JKTopicTypeVideo: {
            self.topicVedioView.hidden = NO;
            self.topicVedioView.topics = topics;
            self.topicPictureView.hidden = YES;
            self.topicVoiceView.hidden = YES;
            break;
        }
        case JKTopicTypeWord: {
            self.topicVedioView.hidden = YES;
            self.topicPictureView.hidden = YES;
            self.topicVoiceView.hidden = YES;
            break;
        }
            
        default:
            break;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.topic.type) {
        case JKTopicTypePicture: {
            self.topicPictureView.frame = self.topic.viewFrame;
            break;
        }
        case JKTopicTypeVideo: {
            self.topicVedioView.frame = self.topic.viewFrame;
            break;
        }
        case JKTopicTypeVoice: {
            self.topicVoiceView.frame = self.topic.viewFrame;
            break;
        }
        case JKTopicTypeWord: {
            break;
        }
            
        default:
            break;
    }
}

- (void)setUpButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.f万", number/ 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }

}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
