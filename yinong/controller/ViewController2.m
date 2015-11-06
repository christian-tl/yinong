//
//  ViewController2.m
//  yinong
//
//  Created by christian on 15/6/26.
//  Copyright (c) 2015年 coolsnow. All rights reserved.
//

#import "ViewController2.h"
#import "YNHttpService.h"

@interface ViewController2 ()
@property (weak, nonatomic) IBOutlet UITextView *content;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.content becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendConetent2:(id)sender {
    NSString *content = self.content.text;
    YNHttpService *service = [[YNHttpService alloc] init];
    [service saveContent:content];
    //[self.view resignFirstResponder];
    [self.navigationController.view removeFromSuperview];
    
    //[self.parentViewController.view becomeFirstResponder];
}

- (IBAction)cancelEdit:(id)sender {

    [self.navigationController.view removeFromSuperview];
  
}

@end
