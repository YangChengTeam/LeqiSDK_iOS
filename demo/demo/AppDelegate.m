//
//  AppDelegate.m
//  demo
//
//  Created by uke_1 on 2020/5/11.
//  Copyright © 2020 ychl. All rights reserved.
//

#import "AppDelegate.h"
#import <leqisdk/LeqiSDK.h>
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(leqiInitResult:)
                                                 name:kLeqiSDKNotiInitDidFinished
                                               object:nil];

    LeqiSDKInitConfigure *config = [LeqiSDKInitConfigure new];
    config.agentid = @"67";
    config.gameid = @"680";
    config.appid = @"680";
    int error = [[LeqiSDK shareInstance] initWithConfig:config];
    if(error != 0){
        NSLog(@"不能启动初始化：%d",error);
    }
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    NSLog(@"SDK版本号：%@", [[LeqiSDK shareInstance] getVersion]);
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

    return YES;
}

- (void)leqiInitResult:(NSNotification *)notify {
    NSLog(@"SDK初始化完成：%@", notify);
    [[LeqiSDK shareInstance] login];
}

@end
