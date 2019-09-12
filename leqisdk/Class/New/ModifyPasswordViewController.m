//
//  修改 ModifyPasswordViewController.m
//  leqisdk
//
//  Created by zhangkai on 2018/1/18.
//  Copyright © 2018年 zhangkai. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController {
    IBOutlet UITextField *pwdField1;
    IBOutlet UITextField *pwdField2;
    IBOutlet UIButton *nextBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    [self setViewHieght:170];
   
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
    [params setObject:self.phone forKey:@"n"];
    __weak typeof(self) weakSelf = self;
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [weakSelf dismiss:nil];
        if(!res){
            return;
        }
        if([res[@"code"] integerValue] == 1 && res[@"data"]){
            NSMutableDictionary *user = [NSMutableDictionary new];
            [user setObject:weakSelf.phone forKey:@"mobile"];
            [user setObject:newPass forKey:@"pwd"];
            [user setObject:@"0" forKey:@"user_id"];
            
            int mainkey = 2;
            [[CacheHelper shareInstance] setUser:user mainKey:mainkey];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshUser object:nil];
            [(UINavigationController *)weakSelf.popupController popToRootViewControllerAnimated:YES];
        } else {
            [weakSelf alertByfail:res[@"msg"]];
        }
    } error:^(NSError * error) {
        [weakSelf showByError:error];
    }];
}


@end
