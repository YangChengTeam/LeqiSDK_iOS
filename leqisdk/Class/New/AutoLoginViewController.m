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
#import "MsgRegistViewController.h"
@interface AutoLoginViewController ()

@end

@implementation AutoLoginViewController {
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *codeField;
    IBOutlet UIButton *loginBt;
    IBOutlet UIButton *checkboxBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"一键注册";
    [self setViewHieght:280];
    
    phoneField.text = self.getUserName;
    codeField.text = self.getPassword;
}

- (IBAction)checkboxAction:(UIButton*)bt {
    [bt setSelected:!bt.isSelected];
}

- (IBAction)agreementLogin:(UIButton*)bt {
    
    AgreementViewController *vc = [AgreementViewController new];
    [self.popupController pushViewController:vc animated:YES];
}

- (IBAction)phoneRegAction:(UIButton*)bt {
    MsgRegistViewController *vc = [[MsgRegistViewController alloc] initWithStoryboardID:@"MsgRegistViewController"];
    [self.popupController pushViewController:vc animated:YES];
}

- (IBAction)backAction:(UIButton*)bt {
    
    [self.popupController popViewControllerAnimated:YES];
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
    if (!checkboxBt.isSelected) {
        [self alert:@"同意用户协议才能注册"];
        return;
    }
    [self show:@"注册中..."];
    [self regWithAccount:username password:password isQuick:YES callback:nil];
}

@end
