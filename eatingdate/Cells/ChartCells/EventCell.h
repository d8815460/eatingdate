//
//  EventCell.h
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView* typeImageView;

@property(nonatomic, strong) IBOutlet UILabel* titleLabel;

@property(nonatomic, strong) IBOutlet UILabel* timeLabel;

@property(nonatomic, strong) IBOutlet UILabel* descriptionLabel;

@end
