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

@property(nonatomic, strong) IBOutlet UIImageView* profileImageView;
@property(nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property(nonatomic, strong) IBOutlet UIImageView* locationImageView;
@property(nonatomic, strong) IBOutlet UILabel* locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eyeIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *beenLookedLabel;
@property (weak, nonatomic) IBOutlet UILabel *askLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoTreatLabel;
@property (weak, nonatomic) IBOutlet UILabel *sinceritygoodLabel;



@end
