//
//  JKLoginViewController.m
//  BuDeJie
//
//  Created by Jerry on 16/4/4.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKLoginViewController.h"
#import "JKLoginRegisterView.h"
#import "JKFastLogin.h"

@interface JKLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *LoginRegisterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginRegisterCons;
@property (weak, nonatomic) IBOutlet UIView *BottomView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation JKLoginViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpLoginView];
    
    
    if (_isRegister) {
        [self RegisterClick:_registerBtn];
    }

}

- (IBAction)RegisterClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.LoginRegisterCons.constant = self.LoginRegisterCons.constant == 0 ? -JKUIScreenW : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)setUpLoginView
{
    JKLoginRegisterView *loginView = [JKLoginRegisterView loginView];
    [self.LoginRegisterView addSubview:loginView];
    
    JKLoginRegisterView *registerView = [JKLoginRegisterView registerView];
    [self.LoginRegisterView addSubview:registerView];
    
    JKFastLogin *fastLoginView = [JKFastLogin fastLoginView];
    [self.BottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    JKLoginRegisterView *loginView = self.LoginRegisterView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.LoginRegisterView.jk_width * 0.5, self.LoginRegisterView.jk_height);
    
    JKLoginRegisterView *registerView = self.LoginRegisterView.subviews[1];
    registerView.frame = CGRectMake(self.LoginRegisterView.jk_width * 0.5, 0, self.LoginRegisterView.jk_width * 0.5, self.LoginRegisterView.jk_height);
    
    JKFastLogin *fastLoginView = self.BottomView.subviews[0];
    fastLoginView.frame = self.BottomView.bounds;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CancelClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
