//
//  AppDelegate.m
//  yinong
//
//  Created by christian on 15/5/4.
//  Copyright (c) 2015年 coolsnow. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    _window.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    
    //设置全局导航条风格和颜色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1]];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
//    [_window makeKeyAndVisible];
//    
//    //注册推送通知（注意iOS8注册方法发生了变化）
//    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    [application registerForRemoteNotifications];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
    }else{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
    }
    
    [NSThread sleepForTimeInterval:3.0];
    return YES;
}


#pragma mark 注册推送通知之后
//在此接收设备令牌
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
   // [self addDeviceToken:deviceToken];
    NSLog(@"device token:%@",deviceToken);
}
#pragma mark 获取device token失败后
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",error.localizedDescription);
    //[self addDeviceToken:nil];
}
#pragma mark 接收到推送通知之后
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"receiveRemoteNotification,userInfo is %@",userInfo);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *alert = apsInfo[@"alert"];
    application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    
//    if ([application applicationState] == UIApplicationStateActive && alert != nil)
//    {
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"意小浓" message:alert delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
