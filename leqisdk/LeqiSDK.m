//
//  YC6071SDK.m
//  ycsdk
//
//  Created by zhangkai on 2018/1/8.
//  Copyright © 2018年 zhangkai. All rights reserved.
//

#import "LeqiSDK.h"
#import "LoginViewController.h"
#import "STPopup.h"
#import "IAPManager.h"
#import "Reg2LoginViewController.h"
#import "NetUtils.h"
#import "XHFloatWindow.h"
#import "AutoLoginViewController.h"
#import "CacheHelper.h"
#import "IAPViewController.h"
#import "HomeViewController.h"
#import "MeNavViewController.h"
#import "AutoLoginViewController.h"
#import "Base64.h"

#define FIRST_LOGIN @"first_login"
#define IC_EE @"WJPFH/vgAho7klpeiK8TPKrN9D7NAS14Zf87PV/KLuKJZfJbNE8BsEvvxttuPDacyK8iQfeC6VoVvUIt1WAFHjJeaESNh5qAQOdvvC3C3P8Fe0J4LA8NVeKj7hVU9xvnykJr8ICV7bSenVQExr5g+OWLNjsYPxfuqUEqEVj36Eg="

@interface LeqiSDK()<IAPManagerDelegate>
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation LeqiSDK {
    BOOL isInitOk;
    BOOL isReInit;
    BOOL isFloatViewAdded;
    
    NSString *currentOrderId;
    
    int n;
}

static LeqiSDK* instance = nil;

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.hasShowing = YES;
        instance.isShowingInWindow = YES;
    });
    
    [IAPManager sharedManager].delegate = instance;
    return instance;
}

#pragma mark -- 初始化
- (int)initWithConfig:(nonnull LeqiSDKInitConfigure *)configure {
    if(isReInit){
        [self show:@"重新初始化..."];
    }
    n = 3;
    self.configInfo = configure;
    if(self.configInfo.gameid){
        NSMutableDictionary *params =[self setParams];
        NSString *url = [NSString stringWithFormat:@"%@%@?ios", @"http://api.6071.com/index3/init/p/", self.configInfo.appid];
        __weak typeof(self) weakSelf = self;
        [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
            if(isReInit){
               [weakSelf dismiss:nil];
            }
            if(!res){
                return;
            }
            if([res[@"code"] integerValue] == 1){
                isInitOk = true;
                [[CacheHelper shareInstance] setInitInfo:res[@"data"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiInitDidFinished object:nil];
            } else {
                if(isReInit){
                    [weakSelf alertByfail:res[@"msg"]];
                }
            }
        } error:^(NSError *error) {
            [weakSelf showByError:error];
        }];
        return LEQI_SDK_ERROR_NONE;
    } else {
        [self alert:@"初始化信息配置错误"];
        return LEQI_SDK_ERROR_INIT_CONFIG_ERROR;
    }
    

}

#pragma mark -- 自动登录
- (void)openAutoLogin {

    HomeViewController *vc = [[HomeViewController alloc] initWithStoryboardID:@"HomeViewController"];
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];
    popupController.navigationBar.tintColor = kColorWithHex(0xF9628B);
    popupController.containerView.layer.cornerRadius = 4;
    [popupController presentInViewController:[BaseViewController  getCurrentViewController]];
}

#pragma mark -- 快速登录
- (void)openQuickLogin {
    [self show:@"请稍后..."];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/reg/p", self.configInfo.appid];
    NSMutableDictionary *params = [self setParams];
    [params setValue:[NSNumber numberWithBool:YES] forKey:@"is_quick"];
    [params setValue:@"" forKey:@"n"];
    [params setValue:@"" forKey:@"p"];
    __weak typeof(self) weakSelf = self;
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [weakSelf dismiss:nil];
        if(!res){
            return;
        }
        if([res[@"code"] integerValue] == 1 && res[@"data"]){
            NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithDictionary:res[@"data"]];
            [[CacheHelper shareInstance] setUser:user mainKey:1];
            
            HomeViewController *vc = [[HomeViewController alloc] initWithStoryboardID:@"HomeViewController"];
            STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];
            popupController.navigationBar.tintColor = kColorWithHex(0xF9628B);
            popupController.containerView.layer.cornerRadius = 4;
            [popupController presentInViewController:[BaseViewController  getCurrentViewController]];
           
            AutoLoginViewController *vc2 = [[AutoLoginViewController alloc] initWithStoryboardID:@"AutoLoginViewController"];
            [popupController pushViewController:vc2 animated:YES];
            
            [[CacheHelper shareInstance] setAutoLogin:YES];
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:FIRST_LOGIN];
            [defaults synchronize];
        } else {
            [weakSelf alertByfail:res[@"msg"]];
        }
    } error:^(NSError * error) {
        [weakSelf showByError:error];
    }];
}

#pragma mark -- 正常登录
- (void)openNormalLogin {
    HomeViewController *vc = [[HomeViewController alloc] initWithStoryboardID:@"HomeViewController"];
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];
    popupController.navigationBar.tintColor = kColorWithHex(0xF9628B);
    popupController.containerView.layer.cornerRadius = 4;
    [popupController presentInViewController:[BaseViewController  getCurrentViewController]];
}

#pragma mark -- 登录
- (int)login {

    if(self.user){
        return LEQI_SDK_ERROR_ALREADY_LOGIN;  //已经登录
    }
    if(!isInitOk){
        isReInit = YES;
        [self initWithConfig: self.configInfo];
        return LEQI_SDK_ERROR_INIT_FAILED; //初始化失败
    }

    BOOL isAutoLogin = [[CacheHelper shareInstance] getAutoLogin];
    if(isAutoLogin){
        NSLog(@"%@:%@", TAG, @"auto login");
        [self openAutoLogin];
        return LEQI_SDK_ERROR_NONE;
    }

    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    BOOL isNotFirstLogin = [defaults boolForKey:FIRST_LOGIN];
    if(!isNotFirstLogin){
        NSLog(@"%@:%@", TAG, @"quick login");
        [self openQuickLogin];
    } else {
        NSLog(@"%@:%@", TAG, @"normal login");
        [self openNormalLogin];
    }
    
    return LEQI_SDK_ERROR_NONE;
}


#pragma mark -- 支付
- (int)payWithOrderInfo:(nonnull LeqiSDKOrderInfo *)orderInfo {
    if(!self.user) return LEQI_SDK_ERROR_NO_LOGIN; //没有登录

    [self show:@"请稍后..."];
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/ios_pay_init/p", self.configInfo.appid];
    NSMutableDictionary *params = [self setParams];
    [params setValue:[self.user objectForKey:@"user_id"] forKey:@"user_id"];
    __weak typeof(self) weakSelf = self;

    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        if(res && res[@"data"]){
            [weakSelf dismiss:nil];
            if([res[@"data"][@"type"] isEqual:IC_EE.keyDecrypt]){
                [weakSelf iapPayISO:orderInfo];
                return;
            }
        }
        [BaseViewController payWithOrderInfo:orderInfo callback:^(id res) {
            if([res isKindOfClass:[NSError class]]){
                [weakSelf showByError:res];
                return;
            }
            
            [weakSelf dismiss:nil];
            if(res && [res[@"code"] integerValue] == 1 && res[@"data"]){
                currentOrderId = res[@"data"][@"order_sn"];
                if([currentOrderId length] > 0){
                    [weakSelf iapPay:orderInfo];
                    return;
                }
            }
        }];
    } error:^(NSError * error) {
        [weakSelf showByError:error];
    }];
    return LEQI_SDK_ERROR_NONE;
}


- (void)iapPayISO:(LeqiSDKOrderInfo *)orderInfo  {
    IAPViewController *vc = [IAPViewController new];
    vc.orderInfo = orderInfo;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];
    popupController.containerView.layer.cornerRadius = 4;
    [popupController presentInViewController:[BaseViewController  getCurrentViewController]];
}

- (void)iapPay:(LeqiSDKOrderInfo *)orderInfo {
    [self show:@"请稍后..."];
    [[IAPManager sharedManager] requestProductWithId: orderInfo.goodId userId: [self.user objectForKey:@"user_id"] count:orderInfo.count];
}

- (void)showFloatView {
    if(!self.user) return;
    if(!isFloatViewAdded){
       [XHFloatWindow xh_addWindowOnTarget:[BaseViewController getCurrentViewController] onClick:^{

           MeNavViewController *nav = [[MeNavViewController alloc] initWithStoryboard];
           [[BaseViewController getCurrentViewController] presentViewController:nav animated:true completion:nil];
       }];
    } else {
        [XHFloatWindow xh_setHideWindow:NO];
    }
    isFloatViewAdded = true;
}

- (void)hideFloatView {
    [XHFloatWindow xh_setHideWindow:YES];
}

#pragma mark -- SDK版本号
- (NSString *)getVersion {
    return @"1.0.97";
}

#pragma mark -- 退出
- (int)logout {
    self.user = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiLogout object:nil];
    return LEQI_SDK_ERROR_NONE;
}

#pragma mark -- 接收内购支付回调
- (void)receiveProduct:(SKProduct *)product {
    NSLog(@"%@:%@", TAG, @"接收内购支付回调");
    [self dismiss:nil];
    if (product != nil) {
        if (![[IAPManager sharedManager] purchaseProduct:product]) {
           [self alert:@"您禁止了应用内购买权限,请到设置中开启!"];
        }
    } else {
        [self alert:@"无法获取产品信息"];
    }
}

#pragma mark -- 订单验证
- (void)checkOrder:(NSString *)transactionReceiptString {
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/ios_order_query/p", self.configInfo.appid];
    NSMutableDictionary *params = [self setParams];
    [params setValue:transactionReceiptString forKey:@"receipt"];
    [params setValue:currentOrderId forKey:@"order_sn"];
    __weak typeof(self) weakSelf = self;
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [[IAPManager sharedManager] finishTransaction];
        if(res && [res[@"code"] integerValue] == 1){
            [weakSelf dismiss:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiPay object:[NSNumber numberWithInt:LEQI_SDK_ERROR_NONE]];      
        } else {
            if(--n > 0){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf checkOrder:transactionReceiptString];
                    });
                });
                return;
            }
            [[CacheHelper shareInstance] setCheckFailOrder:params];
            [weakSelf dismiss:nil];
            n = 3;
            [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiPay object:[NSNumber numberWithInt:LEQI_SDK_ERROR_RECHARGE_FAILED]];
        }
    } error:^(NSError * error) {
        [weakSelf showByError:error];
        if(!error){
            [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiPay object:[NSNumber numberWithInt:LEQI_SDK_ERROR_RECHARGE_FAILED]];
        }
    }];
}

#pragma mark -- 购买成功
- (void)successedWithReceipt:(NSData *)transactionReceipt {
    NSLog(@"%@:%@", TAG, @"购买成功 开始验证订单");
    NSString  *transactionReceiptString = [transactionReceipt base64EncodedStringWithOptions:0];
    if ([transactionReceiptString length] > 0) {
        [self show:@"订单校验中..."];
        [self checkOrder:transactionReceiptString];
    }
}


#pragma mark -- 购买失败
- (void)failedPurchaseWithError:(NSString *)errorDescripiton {
    NSLog(@"%@:%@", TAG, @"购买失败");
    [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiPay object:[NSNumber numberWithInt:LEQI_SDK_ERROR_RECHARGE_FAILED]];
}

#pragma mark -- 取消购买
- (void)canceledPurchaseWithError:(NSString *)errorDescripiton {
    NSLog(@"%@:%@", TAG, @"取消购买");
    [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiPay object:[NSNumber numberWithInt:LEQI_SDK_ERROR_RECHARGE_CANCELED]];
}

#pragma mark -- 显示Loading
- (void)show:(NSString *)message {
    if(!self.hasShowing) return;
    UIViewController *currentViewController = [BaseViewController getCurrentViewController];
    if(self.isShowingInWindow){
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        NSLog(@"%@:window%@", TAG, window);
        self.hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    } else {
        NSLog(@"%@:currentViewController%@", TAG, currentViewController);
        self.hud = [MBProgressHUD showHUDAddedTo:currentViewController.view animated:YES];
    }
    self.hud.label.font = [UIFont systemFontOfSize: 14];
    self.hud.label.text = message;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(self.hud){
//                [self.hud hideAnimated:YES];
//                self.hud = nil;
//            }
//        });
//    });
}

#pragma mark -- 关闭Loading
- (void)dismiss:(void (^)(void))callback {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        if(callback){
            callback();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(weakSelf.hud){
                [weakSelf.hud hideAnimated:YES];
                weakSelf.hud = nil;
            }
        });
    });
}

- (void)showByError:(NSError *)error {
    [self dismiss:nil];
    if(error){
        [self show:@"重试中..."];
    }
}

#pragma mark -- alert
- (void)alert:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertByfail:(NSString *)message {
    NSString *msg = [message stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]];
    if([msg length] == 0){
        msg = @"服务器未知错误, 请重试";
        message = msg;
    }
    [self alert:message];
}

#pragma mark -- 设置默认参数
- (NSMutableDictionary *)setParams {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    NSString *version = [self getVersion];
    [params setValue:version forKey:@"version"];
    NSString *agentid = self.configInfo.agentid;
    
    if(agentid){
        [params setValue:agentid forKey:@"a"];
    } else {
        [params setValue:agentid forKey:@"default"];
    }
    
    NSString *gameid = self.configInfo.gameid;
    [params setValue:gameid forKey:@"g"];
    
    return params;
}



@end
