//
//  MsgRegistViewController.m
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "MsgRegistViewController.h"
#import "AutoLoginViewController.h"
#import "AgreementViewController.h"

@interface MsgRegistViewController ()

@end

@implementation MsgRegistViewController {
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *codeField;
    IBOutlet UITextField *pwdField;
    IBOutlet UIButton *codeBt;
    IBOutlet UIButton *loginBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机注册";
    [self setViewHieght: 290];
}

- (IBAction)agreementAction:(UIButton*)bt {
    
    AgreementViewController *vc = [AgreementViewController new];
    [self.popupController pushViewController:vc animated:YES];
}

- (IBAction)codeAction:(UIButton*)bt {
    
    NSString *phone = phoneField.text;
    if([phone length] == 0){
        [self alert:@"请输入手机号"];
        return;
    }
    
    [self show:@"获取中..."];
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/mobile_reg_sendCode/p", [LeqiSDK shareInstance].configInfo.appid];
    NSMutableDictionary *params = [[LeqiSDK shareInstance] setParams];
    [params setObject:phone forKey:@"m"];
    __weak typeof(self) weakSelf = self;
    [bt setEnabled:NO];
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [weakSelf dismiss:nil];
        if(!res){
            return;
        }
        if([res[@"code"] integerValue] == 1 && res[@"data"]){
            [weakSelf dismiss:nil];
            [weakSelf initWithGCD:59 beginState:^(int seconds){
                [bt setTitle:[NSString stringWithFormat:@"%d",seconds] forState:UIControlStateDisabled];
            } endState:^{
                [bt setEnabled:YES];
            }];
            [weakSelf alert:@"验证码已发送，请注意查收"];
        } else {
            [weakSelf alertByfail:res[@"msg"]];
        }
    } error:^(NSError * error) {
        [bt setEnabled:YES];
        [self showByError:error];
    }];
}

- (IBAction)autoLoginAction:(UIButton*)bt {
    
    AutoLoginViewController *vc = [[AutoLoginViewController alloc] initWithStoryboardID:@"AutoLoginViewController"];
    [self.popupController pushViewController:vc animated:YES];
}

- (IBAction)backAction:(UIButton*)bt {
    
    [self.popupController popViewControllerAnimated:YES];
}

- (IBAction)registAction:(UIButton*)bt {
    NSString *phone = phoneField.text;
    NSString *code = codeField.text;
    NSString *password = pwdField.text;
    if([phone length] == 0){
        [self alert:@"请输入手机号"];
        return;
    }
    
    if([code length] == 0){
        [self alert:@"请输入验证码"];
        return;
    }
    if([password length] == 0){
        [self alert:@"请输入密码"];
        return;
    }
    NSString *pattern = @"(^[A-Za-z0-9]{6,16}$)";;
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if(![regex evaluateWithObject:password]){
        [self alert:@"密码只能由6至16位16位英文或数字组成"];
        return;
    }
    [self show:@"注册中..."];
    [self regWithAccount:phone password:password isQuick:NO callback:nil];
//    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/mobile_regORlogin/p", [LeqiSDK shareInstance].configInfo.appid];
//    NSMutableDictionary *params =  [[LeqiSDK shareInstance] setParams];
//    [params setObject:phone forKey:@"m"];
//    [params setObject:code forKey:@"code"];
//    [params setValue:[NSNumber numberWithBool:NO] forKey:@"is_quick"];
//    __weak typeof(self) weakSelf = self;
//    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
//        [weakSelf dismiss:nil];
//        if(weakSelf.isCancel){
//            return;
//        }
//        weakSelf.noCancel = true;
//        if(!res){
//            return;
//        }
//        if([res[@"code"] integerValue] == 1 && res[@"data"]){
//            NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithDictionary:res[@"data"]];
//            int mainkey = 1;
//            if([[user objectForKey:@"is_vali_mobile"] intValue] == 1 && [[user objectForKey:@"mobile"] isEqualToString:phone]){
//                mainkey = 2;
//            }
//            [[CacheHelper shareInstance] setUser:user mainKey:mainkey];
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
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiLogin object:nil];
//        }
//    } error:^(NSError * error) {
//        [weakSelf showByError:error];
//        if(!error){
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLeqiSDKNotiLogin object:nil];
//        }
//    }];
}
@end
