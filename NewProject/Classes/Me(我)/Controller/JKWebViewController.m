//
//  JKWebViewController.m
//  BuDeJie
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKWebViewController.h"
#import <WebKit/WebKit.h>

@interface JKWebViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) WKWebView *webView;

@end

@implementation JKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView = webView;
    [self.view insertSubview:webView atIndex:0];
    
    // 加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
    
    // KVO: 让self对象监听webView的estimatedProgress
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.progressView.progress = self.webView.estimatedProgress;
    
    self.progressView.hidden = self.progressView.progress >= 1;
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
