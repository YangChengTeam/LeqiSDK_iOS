//
//  HomeViewController.m
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "HomeViewController.h"
#import "UserCell.h"
#import "ForgotPasswordViewController.h"
#import "MsgLoginViewController.h"
#import "MsgRegistViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation HomeViewController {
    IBOutlet UIButton *downBt;
    IBOutlet UIButton *loginBt;
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *pwdField;
    IBOutlet UITableView *tableView;
    IBOutlet NSLayoutConstraint *tableHeightConstraint;
    
    NSMutableArray *datasource;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    datasource = [[CacheHelper shareInstance] getUsers];
    [downBt setHidden:datasource.count < 2];
    if (downBt.isSelected) {
        tableHeightConstraint.constant = MIN(datasource.count * 40, 160);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self setViewHieght: 270];
    phoneField.text = self.getUserName;
    pwdField.text = self.getPassword;
}

- (IBAction)downAction:(UIButton *)bt {
    [bt setSelected: !bt.isSelected];
    tableHeightConstraint.constant = bt.isSelected ? MIN(datasource.count * 40, 160) : 0;
    [tableView reloadData];
}

- (IBAction)forgotPwdAction:(UIButton *)bt {
    ForgotPasswordViewController *vc = [[ForgotPasswordViewController alloc] initWithStoryboardID:@"ForgotPasswordViewController"];
    [self.popupController pushViewController:vc animated:YES];
}

- (IBAction)loginAction:(UIButton *)bt {
    NSString *username = phoneField.text;
    NSString *password = pwdField.text;
    if([username length] == 0){
        [self alert:@"请输入账号"];
        return;
    }
    if([password length] == 0){
        [self alert:@"请输入密码"];
        return;
    }
    NSString *pattern = @"(^[A-Za-z0-9]{6,16}$)";;
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if(![regex evaluateWithObject:username]){
        [self alert:@"账号只能由6至16位英文或数字组成"];
        return;
    }
    
    if(![regex evaluateWithObject:password]){
        [self alert:@"密码只能由6至16位16位英文或数字组成"];
        return;
    }
    [self show:@"登录中..."];
    [self loginWithAccount:username password:password];
}

- (IBAction)msgLoginAction:(UIButton *)bt {
    MsgLoginViewController *vc = [[MsgLoginViewController alloc] initWithStoryboardID:@"MsgLoginViewController"];
    [self.popupController pushViewController:vc animated:YES];
}

- (IBAction)registAction:(UIButton *)bt {
    MsgRegistViewController *vc = [[MsgRegistViewController alloc] initWithStoryboardID:@"MsgRegistViewController"];
    [self.popupController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [datasource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    NSDictionary *dict = datasource[indexPath.row];
    NSString *n = [self getUserName:dict];
    cell.nameLabel.text = n;
    [cell.cancelBt setHidden: [n isEqualToString:self.getUserName]];
    cell.cancelBt.tag = 100 + indexPath.row;
    [cell.cancelBt addTarget:self action:@selector(deleteUser:) forControlEvents: UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = datasource[indexPath.row];
    phoneField.text = [self getUserName:dict];
    pwdField.text = [self getPassword:dict];
    [self downAction:downBt];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)deleteUser:(UIButton*)bt {

    NSDictionary *dict = datasource[bt.tag - 100];
    [datasource removeObject:dict];
    [[CacheHelper shareInstance] setUsers:datasource];
    [tableView reloadData];
    tableHeightConstraint.constant = downBt.isSelected ? MIN(datasource.count * 40, 160) : 0;
    [downBt setHidden:datasource.count < 2];
}

@end
