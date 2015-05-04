//
//  TimelineCell.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView* typeImageView;
@property(nonatomic, strong) IBOutlet UIImageView* profileImageView;
@property(nonatomic, strong) IBOutlet UIImageView* dateImageView;
@property(nonatomic, strong) IBOutlet UIImageView* photoImageView;

@property(nonatomic, strong) IBOutlet UILabel* nameLabel;
@property(nonatomic, strong) IBOutlet UILabel* postLabel;
@property(nonatomic, strong) IBOutlet UILabel* dateLabel;

@end
