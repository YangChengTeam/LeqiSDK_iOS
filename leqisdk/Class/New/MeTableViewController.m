//
//  MeTableViewController.m
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "MeTableViewController.h"
#import "CacheHelper.h"
#import "MeModifyPwdViewController.h"
#import "MeBindPhoneViewController.h"
#import "MeAuthViewController.h"
#import "LeqiSDK.h"

@interface MeTableViewController ()

@end

@implementation MeTableViewController {
    
    IBOutlet UIImageView *authArrow;
    IBOutlet UIImageView *bindArrow;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *authLabel;
    IBOutlet UILabel *bindLabel;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    nameLabel.text = self.getUserName;
    BOOL auth = [[CacheHelper shareInstance]getRealAuth];
    [authLabel setHidden: !auth];
    [authArrow setHidden: auth];
    BOOL bind = [[[self getUser] objectForKey:@"is_vali_mobile"] intValue] == 1;
    [bindLabel setHidden: !bind];
    [bindArrow setHidden: bind];
}

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)backAction:(UIButton*)bt {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)authAction:(UIButton*)bt {
    
    MeAuthViewController *vc = [[MeAuthViewController alloc] initWithStoryboardID:@"MeAuthViewController"];
    [self.navigationController showViewController:vc sender:nil];
}

- (IBAction)bindAction:(UIButton*)bt {
    
    MeBindPhoneViewController *vc = [[MeBindPhoneViewController alloc] initWithStoryboardID:@"MeBindPhoneViewController"];
    [self.navigationController showViewController:vc sender:nil];
}

- (IBAction)logoutAction:(UIButton*)bt {
    
    [[LeqiSDK shareInstance] logout];
}

- (NSDictionary *)getUser {
    NSDictionary *user = [LeqiSDK shareInstance].user;
    if(!user){
        user = [[CacheHelper shareInstance] getCurrentUser];
    }
    return user;
}

- (NSString *)getUserName {
    NSDictionary *user = [self getUser];
    NSString *username = @"";
    if(user){
        if([[user objectForKey:MAIN_KEY] intValue] == 1){
            username = [user objectForKey:@"name"];
        } else {
            username = [user objectForKey:@"mobile"];
        }
    }
    return username;
}
@end
