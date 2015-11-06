//
//  YITabBarController.m
//  yinong
//
//  Created by christian on 15/6/26.
//  Copyright (c) 2015年 coolsnow. All rights reserved.
//

#import "YITabBarController.h"
#import "SendContentController.h"
#import "ViewController.h"

#define BASE_HIGHT 60
#define FUN_ICON 16
#define FUN_ICON_DISTINCE 13



#import "UConstants.h"

#define SNOW_IMAGENAME         @"snow"

#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 10
#define PLUS_HEIGHT            Main_Screen_Height/25


@interface YITabBarController ()
@property (retain ,nonatomic) UINavigationController *vc;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property(nonatomic) CGFloat tabbarheight;
@property(nonatomic) BOOL canswitch;
@end

@implementation YITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScreen *s=[UIScreen mainScreen];
    CGFloat wid=[s bounds].size.width;
    CGFloat height=[s bounds].size.height ;
    self.width = wid;
    self.height = height;
    self.tabbarheight = self.tabBar.frame.size.height;
//    self.tabbarheight = 120;
    self.canswitch = YES;

    [self addCenterButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addCenterButton{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"add"];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.tag = 201;
    button.frame = CGRectMake(0,0, self.tabbarheight, self.tabbarheight);
    button.center = CGPointMake(self.width/2, self.height-self.tabbarheight/2);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openPage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILongPressGestureRecognizer *longPressReger = [[UILongPressGestureRecognizer alloc]
                                                    
                                                    initWithTarget:self action:@selector(handleLongPress:)];
    
    longPressReger.minimumPressDuration = 1.0;
    
    [button addGestureRecognizer:longPressReger];

    
    [self.view addSubview:button];
}


-(void)add4Icon{
    NSArray *array = @[[UIImage imageNamed:@"word"],[UIImage imageNamed:@"book"],[UIImage imageNamed:@"music"],[UIImage imageNamed:@"movie"]];
    int index = 101;
    for(UIImage *img in array){
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index++;
        button.frame = CGRectMake(0,0, FUN_ICON, FUN_ICON);
        button.center = CGPointMake(self.width/2, self.height-BASE_HIGHT);
        [button setImage:img forState:UIControlStateNormal];
        [button addTarget:self action:@selector(openPage:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view insertSubview:button atIndex:0];
        [self.view addSubview:button];
    }
}

-(void)openPage:(UIButton *)button{
    //    NSLog(@"1111 == %@",self.navigationController);
    [self createContent];
}

-(void)createContent{
    self.vc = [self.storyboard instantiateViewControllerWithIdentifier:@"send111"];
    [self.view addSubview:self.vc.view];
}


@end
