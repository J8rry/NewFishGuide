//
//  JKTextField.m
//  NewProject
//
//  Created by Jerry on 16/5/8.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "JKTextField.h"
#import "UITextField+Placeholder.h"

@implementation JKTextField

- (void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    self.placeholderColor = [UIColor lightGrayColor];
    
}

- (void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
}

- (void)textEnd
{
    self.placeholderColor = [UIColor lightGrayColor];
}



@end
