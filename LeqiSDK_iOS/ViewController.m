//
//  ViewController.m
//  LeqiSDK_iOS
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "ViewController.h"
#import <leqisdk/LeqiSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(leqiLoginResult:)
                                                 name:kLeqiSDKNotiLogin
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(leqiPayResult:)
                                                 name:kLeqiSDKNotiPay
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(leqiLogoutResult:)
                                                 name:kLeqiSDKNotiLogout
                                               object:nil];



}

- (IBAction)loginAction {
    if([LeqiSDK shareInstance].user){
        [[LeqiSDK shareInstance] logout];
        return;
    }
    [[LeqiSDK shareInstance] login];
}

- (IBAction)payAction {
    LeqiSDKOrderInfo *orderInfo = [LeqiSDKOrderInfo new];
    orderInfo.goodId = @"com.leqi.bxxyios.rbm30";
    orderInfo.productName = @"阴阳师:640枚勾玉";
    orderInfo.amount = 0.02;
    orderInfo.count = 1;
    orderInfo.roleId = @"角色名";
    orderInfo.orderId = @"111111111";
    orderInfo.serverId = @"11111122";
    [[LeqiSDK shareInstance] payWithOrderInfo:orderInfo];
}


- (void)leqiLoginResult:(NSNotification *)notify {
    NSLog(@"leqiLoginResult:%@", notify.object);
}

- (void)leqiPayResult:(NSNotification *)notify {
    NSLog(@"leqiPayResult:%@", notify.object);
}

- (void)leqiLogoutResult:(NSNotification *)notify {
    [[LeqiSDK shareInstance] login];
    NSLog(@"leqiLogoutResult:%@", notify.object);
}

@end
