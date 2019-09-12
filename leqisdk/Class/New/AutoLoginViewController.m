//
//  AutoLoginViewController.m
//  leqisdk
//
//  Created by zhangkai on 2018/1/19.
//  Copyright © 2018年 zhangkai. All rights reserved.
//

#import "AutoLoginViewController.h"
#import "LoginViewController.h"
#import "AgreementViewController.h"
@interface AutoLoginViewController ()

@end

@implementation AutoLoginViewController {
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *codeField;
    IBOutlet UIButton *loginBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速注册";
    [self setViewHieght:270];
    
    phoneField.text = self.getUserName;
    codeField.text = self.getPassword;
}

- (IBAction)agreementLogin:(UIButton*)bt {
    
    AgreementViewController *vc = [AgreementViewController new];
    [self.popupController pushViewController:vc animated:YES];
}

- (IBAction)registLogin:(UIButton*)bt {
    NSString *username = phoneField.text;
    NSString *password = codeField.text;
    if([username length] == 0){
        [self alert:@"请输入账号"];
        return;
    }
    if([password length] == 0){
        [self alert:@"请输入密码"];
        return;
    }
    NSString *pattern = @"(^[A-Za-z0-9]{6,16}$)";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if(![regex evaluateWithObject:username]){
        [self alert:@"账号只能由6至16位英文或数字组成"];
        return;
    }
    
    if(![regex evaluateWithObject:password]){
        [self alert:@"密码只能由6至16位16位英文或数字组成"];
        return;
    }
    [self show:@"注册中..."];
//    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/reg/p", [LeqiSDK shareInstance].configInfo.appid];
//    NSMutableDictionary *params = [[LeqiSDK shareInstance] setParams];
//    [params setValue:[NSNumber numberWithBool:YES] forKey:@"is_quick"];
//    [params setValue:username forKey:@"n"];
//    [params setValue:password forKey:@"p"];
//    __weak typeof(self) weakSelf = self;
//    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
//        [weakSelf dismiss:nil];
//        if(!res){
//            return;
//        }
//        if([res[@"code"] integerValue] == 1 && res[@"data"]){
//            NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithDictionary:res[@"data"]];
//            [[CacheHelper shareInstance] setUser:user mainKey:1];
//            NSDictionary *dict = @{
//                                   @"userId":[user objectForKey:@"user_id"],
//                                   @"sign":[user objectForKey:@"sign"],
//                                   @"loginTime": [user objectForKey:@"last_login_time"]
//                                   };
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiLogin object:dict];
//            [LeqiSDK shareInstance].user = user;
//            [weakSelf.popupController dismiss];
//            [[LeqiSDK shareInstance] showFloatView];
//        } else {
//            [weakSelf alertByfail:res[@"msg"]];
//        }
//    } error:^(NSError * error) {
//        [weakSelf showByError:error];
//    }];
    [self regWithAccount:username password:password isQuick:YES callback:nil];
}

@end
