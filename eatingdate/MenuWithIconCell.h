//
//  MenuWithIconCell.h
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/7/5.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuWithIconCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *logoView;
@property (strong, nonatomic) IBOutlet UILabel *unReadNumberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *unReadCircle;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end
