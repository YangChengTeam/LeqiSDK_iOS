//
//  FeedbackContainer.m
//  leqisdk
//
//  Created by uke on 2019/9/16.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import "FeedbackContainer.h"

@interface FeedbackContainer ()

@end

@implementation FeedbackContainer {
    IBOutlet UIButton *submitBt;
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *zoneField;
    IBOutlet UITextField *roleField;
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *qqField;
    IBOutlet UITextView *desField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (IBAction)submitAction:(UIButton*)bt {
    

}
@end
