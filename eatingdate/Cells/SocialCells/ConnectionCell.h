//
//  ConnectionCell.h
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView* iconImageView;

@property(nonatomic, strong) IBOutlet UILabel* titleLabel;

@property(nonatomic, strong) IBOutlet UISwitch* switchView;


@end
