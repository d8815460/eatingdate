//
//  PictureCell.h
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView* bgImageView;

@property(nonatomic, strong) IBOutlet UILabel* nameLabel;
@property(nonatomic, strong) IBOutlet UIImageView* profileImageView;

@property(nonatomic, strong) IBOutlet UIImageView* locationImageView;
@property(nonatomic, strong) IBOutlet UILabel* locationLabel;
@property(nonatomic, strong) IBOutlet UIImageView* commentsImageView;
@property(nonatomic, strong) IBOutlet UILabel* commentsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *restaurantLabel;

@end
