//
//  MeAuthViewController.m
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "MeAuthViewController.h"

@interface MeAuthViewController ()

@end

@implementation MeAuthViewController{
    
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *numField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backAction:(UIButton*)bt {
    
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)submitAction:(UIButton*)bt {
    
    NSString *realName = nameField.text;
    NSString *cardNum = numField.text;
    
    if([realName length] < 2){
        [self alert:@"请输入真实姓名"];
        return;
    }
    
    if([cardNum length] == 0){
        [self alert:@"请输入身份证号"];
        return;
    }
    
    if([cardNum length] < 10){
        [self alert:@"请输入正确的身份证号"];
        return;
    }
    [self show:@"请稍后..."];
    NSString *url = [NSString stringWithFormat:@"%@/%@?ios", @"http://api.6071.com/index3/real_auth/p", [LeqiSDK shareInstance].configInfo.appid];
    NSMutableDictionary *params = [[LeqiSDK shareInstance] setParams];
    [params setObject:[[self getUser] objectForKey:@"user_id"] forKey:@"user_id"];
    [params setObject:realName  forKey:@"real_name"];
    [params setObject:cardNum  forKey:@"card_num"];
    __weak typeof(self) weakSelf = self;
    
    [NetUtils postWithUrl:url params:params callback:^(NSDictionary *res){
        [weakSelf dismiss:nil];
        if(!res){
            return;
        }
        if([res[@"code"] integerValue] == 1 && res[@"data"]){
            [weakSelf alert:@"身份认证成功"];
            [[CacheHelper shareInstance] setRealAuth];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshMenu object:nil];
            [(UINavigationController *)weakSelf.popupController popToRootViewControllerAnimated:YES];
        } else {
            [weakSelf alertByfail:res[@"msg"]];
        }
    } error:^(NSError * error) {
        [weakSelf showByError:error];
    }];
}


@end
