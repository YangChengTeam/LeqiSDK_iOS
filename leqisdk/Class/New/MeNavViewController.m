//
//  MeNavViewController.m
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "MeNavViewController.h"
#import "BaseViewController.h"

@interface MeNavViewController ()

@end

@implementation MeNavViewController

- (instancetype)initWithStoryboard
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UI" bundle:leqiBundle];
    return [sb instantiateViewControllerWithIdentifier:@"MeNavViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
