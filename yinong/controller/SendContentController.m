//
//  SendContentController.m
//  yinong
//
//  Created by christian on 15/6/16.
//  Copyright (c) 2015年 coolsnow. All rights reserved.
//

#import "SendContentController.h"
#import "ViewController.h"
#import "YNHttpService.h"

@interface SendContentController ()
@property (weak, nonatomic) IBOutlet UITextView *content;

@end

@implementation SendContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.content becomeFirstResponder];;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendContent:(id)sender {
    //ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"root"];
    //[self presentViewController:vc animated:YES completion:^{}];
    
    //[self.navigationController pushViewController:vc  animated:YES];
    //[self.navigationController popToViewController:self animated:NO];
    NSString *content = self.content.text;
    YNHttpService *service = [[YNHttpService alloc] init];
    [service saveContent:content];
    [self.navigationController popViewControllerAnimated:true];
    
}

-(void)push2SendContent{
//    ViewController *vc = self;
//    [self.navigationController pushViewController:vc animated:NO];
    NSLog(@"jsakdhkajshdkjhajskdhjas.......-------******");
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
