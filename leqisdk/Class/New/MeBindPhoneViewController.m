//
//  MeBindPhoneViewController.m
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "MeBindPhoneViewController.h"

@interface MeBindPhoneViewController ()

@end

@implementation MeBindPhoneViewController{
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *codeField;
    IBOutlet UIButton *codeBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)submitAction:(UIButton*)bt {
    
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
    
    [self show:@"请稍后..."];
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/bind_mobile/p", [LeqiSDK shareInstance].configInfo.appid];
    NSMutableDictionary *params = [[LeqiSDK shareInstance] setParams];
    [params setObject:phone forKey:@"m"];
    [params setObject:code forKey:@"code"];
    [params setObject:[[self getUser]  objectForKey:@"name"] forKey:@"n"];
    __weak typeof(self) weakSelf = self;
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [weakSelf dismiss:nil];
        if(!res){
            return;
        }
        if([res[@"code"] integerValue] == 1 && res[@"data"]){
            NSMutableDictionary *user = [weakSelf getUser];
            [user setObject:[NSNumber numberWithInt:1] forKey:@"is_vali_mobile"];
            [user setObject:phone forKey:@"mobile"];
            [[CacheHelper shareInstance] setUser:user mainKey:[[user objectForKey:MAIN_KEY] intValue]];
            [weakSelf backAction:nil];
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
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/bind_mobile_send_code/p", [LeqiSDK shareInstance].configInfo.appid];
    NSMutableDictionary *params = [[LeqiSDK shareInstance] setParams];
    [params setObject:phone forKey:@"m"];
    [params setObject:[[self getUser]  objectForKey:@"name"] forKey:@"n"];

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

- (IBAction)backAction:(UIButton*)bt {
    
    [self.navigationController popViewControllerAnimated:true];
}
@end
