//
//  ForgotPasswordViewController.m
//  leqisdk
//
//  Created by zhangkai on 2018/1/10.
//  Copyright © 2018年 zhangkai. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ModifyPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController {
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *codeField;
    IBOutlet UIButton *codeBt;
    IBOutlet UIButton *nextBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    [self setViewHieght:250];
    
}

- (IBAction)nextAction:(UIButton*)bt {
    NSString *phone = phoneField.text;
    NSString *code = codeField.text;
    
    if([phone length] == 0){
        [self alert:@"请输入手机号"];
        return;
    }
    
    if([code length] == 0){
        [self alert:@"请输入验证码"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/mobile_regORlogin/p", [LeqiSDK shareInstance].configInfo.appid];
    NSMutableDictionary *params = [[LeqiSDK shareInstance] setParams];
    [params setObject:phone forKey:@"m"];
    [params setObject:code forKey:@"code"];
    __weak typeof(self) weakSelf = self;
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [weakSelf dismiss:nil];
        if(!res){
            return;
        }
        if([res[@"code"] integerValue] == 1 && res[@"data"]){
            ModifyPasswordViewController *vc = [[ModifyPasswordViewController alloc]initWithStoryboardID:@"ModifyPasswordViewController"];
            vc.phone = phone;
            [weakSelf.popupController pushViewController:vc animated:YES];
        } else {
            [weakSelf alertByfail:res[@"msg"]];
        }
    } error:^(NSError * error) {
        [weakSelf showByError:error];
    }];
}

- (IBAction)codeAction:(UIButton*)bt {

    NSString *phone = phoneField.text;
    if([phone length] == 0){
        [self alert:@"请输入手机号"];
        return;
    }
    
    [self show:@"获取中..."];
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/send_code/p", [LeqiSDK shareInstance].configInfo.appid];
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

@end
