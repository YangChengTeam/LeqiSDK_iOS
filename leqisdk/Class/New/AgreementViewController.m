//
//  AgreementViewController.m
//  leqisdk
//
//  Created by zhangkai on 2019/7/12.
//  Copyright © 2019 zhangkai. All rights reserved.
//

#import "AgreementViewController.h"
#import <WebKit/WebKit.h>
#import <WebKit/WKWebView.h>

@interface AgreementViewController ()

@end

@implementation AgreementViewController {
    WKWebView *_webView;
    NSString *filePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户协议";
    if(IsPortrait){
        [self setViewHieght: 400];
    } else {
        [self setViewHieght: 240];
    }
    
    filePath = [leqiBundle pathForResource:@"yhxy" ofType:@"html"];
    NSError *error;
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    _webView = [[WKWebView alloc] init];
    [_webView loadHTMLString:htmlString baseURL:nil];

    [self.view addSubview:_webView];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _webView.frame = self.view.bounds;
}

@end
