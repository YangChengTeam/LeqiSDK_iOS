//
//  MeModifyPwdViewController.m
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "MeModifyPwdViewController.h"

@interface MeModifyPwdViewController ()

@end

@implementation MeModifyPwdViewController {
    IBOutlet UITextField *pwdField1;
    IBOutlet UITextField *pwdField2;
    IBOutlet UIButton *nextBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backAction:(UIButton*)bt {
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)nextAction:(UIButton*)bt {
    NSString *newPass = pwdField1.text;
    NSString *againPass = pwdField2.text;
    
    if([newPass length] == 0){
        [self alert:@"请输入新密码"];
        return;
    }
    NSString *pattern = @"(^[A-Za-z0-9]{6,16}$)";;
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if(![regex evaluateWithObject:newPass]){
        [self alert:@"新密码只能由6至16位英文或数字组成"];
        return;
    }
    
    if(![newPass isEqualToString:againPass]){
        [self alert:@"两次密码输入不一致"];
        return;
    }
    [self show:@"请稍后..."];
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/upd_pwd/p", [LeqiSDK shareInstance].configInfo.appid];
    NSMutableDictionary *params = [[LeqiSDK shareInstance] setParams];
    [params setObject:newPass forKey:@"new_pwd"];
    [params setObject:[self getUserName]  forKey:@"n"];
    [params setObject:[self getPassword]  forKey:@"old_pwd"];
    __weak typeof(self) weakSelf = self;
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [weakSelf dismiss:nil];
        if(res && [res[@"code"] integerValue] == 1 && res[@"data"]){
            NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithDictionary:[weakSelf getUser]];
            [user setObject:newPass forKey:@"pwd"];
            int mainkey = [[user objectForKey:MAIN_KEY] intValue];
            [[CacheHelper shareInstance] setUser:user mainKey:mainkey];
            [(UINavigationController *)weakSelf.popupController popToRootViewControllerAnimated:YES];
        } else {
            [weakSelf alertByfail:res[@"msg"]];
        }
    } error:^(NSError * error) {
        [weakSelf showByError:error];
    }];
}

@end
