//
//  leqisdk.h
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LeqiSDKInitConfigure.h"
#import "LeqiSDKOrderInfo.h"
//! Project version number for leqisdk.
FOUNDATION_EXPORT double leqisdkVersionNumber;

//! Project version string for leqisdk.
FOUNDATION_EXPORT const unsigned char leqisdkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <leqisdk/PublicHeader.h>



#define kLeqiSDKNotiInitDidFinished @"kLeqiSDKNotiInitDidFinished"  //初始化回调
#define kLeqiSDKNotiLogin @"kLeqiSDKNotiLogin"  //登录回调
#define kLeqiSDKNotiLogout @"kLeqiSDKNotiLogout"  //注销回调
#define kLeqiSDKNotiPay @"kLeqiSDKNotiPay"  //支付回调

#define LEQI_SDK_ERROR_NONE 0   //成功
#define LEQI_SDK_ERROR_INIT_FAILED  -10001  //初始化失败
#define LEQI_SDK_ERROR_NO_LOGIN  -10002 //没有登录
#define LEQI_SDK_ERROR_ALREADY_LOGIN  -10003  //已经登录
#define LEQI_SDK_ERROR_RECHARGE_FAILED   -10004  //支付失败
#define LEQI_SDK_ERROR_RECHARGE_CANCELED - 10005 //支付取消
#define LEQI_SDK_ERROR_INIT_CONFIG_ERROR  -10006  //初始化信息配置错误

@interface LeqiSDK : NSObject
@property (nonatomic, strong) NSMutableDictionary *user;
@property (nonatomic, strong) LeqiSDKInitConfigure *configInfo;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, assign) BOOL hasShowing;
@property (nonatomic, assign) BOOL isShowingInWindow;

+ (instancetype) shareInstance;

- (int)initWithConfig:(nonnull LeqiSDKInitConfigure *)configure;

- (int)login;

- (int)payWithOrderInfo:(nonnull LeqiSDKOrderInfo *)orderInfo;

- (void)showFloatView;

- (void)hideFloatView;

- (int)logout;

- (NSString *)getVersion;

- (NSMutableDictionary *)setParams;

@end


