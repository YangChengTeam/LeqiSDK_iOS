//
//  UserCell.h
//  leqisdk
//
//  Created by uke on 2019/9/4.
//  Copyright © 2019 yangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBt;

@end

NS_ASSUME_NONNULL_END
