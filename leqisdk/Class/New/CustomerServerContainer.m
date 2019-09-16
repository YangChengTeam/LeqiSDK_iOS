//
//  CustomerServerContainer.m
//  leqisdk
//
//  Created by uke on 2019/9/16.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "CustomerServerContainer.h"
#import "FeedbackViewController.h"

@interface CustomerServerContainer ()

@end

@implementation CustomerServerContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)qqAction {
    
    @try {
        NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web"  , @"2899841566"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    } @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请先安装QQ" message:@"" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alert show];
    } @finally {
        
    }
}

- (IBAction)weixinAction {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"leqi6071";
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"已复制到剪切板" message:@"" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)callAction {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001886017"] options:@{} completionHandler:nil];
}

- (IBAction)feedbackAction {
    
    FeedbackViewController *vc = [[FeedbackViewController alloc]initWithStoryboardID:@"FeedbackViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
