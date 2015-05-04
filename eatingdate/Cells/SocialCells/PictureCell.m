//
//  PictureCell.m
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "PictureCell.h"
#import "MegaTheme.h"

@implementation PictureCell

- (void)awakeFromNib {
    // Initialization code
    self.locationImageView.tintColor = [UIColor colorWithRed:0.16 green: 0.75 blue: 0.56 alpha: 1.0];
    self.locationImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.locationImageView.image = [[UIImage imageNamed:@"location"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.commentsImageView.tintColor = [UIColor colorWithRed: 0.16 green: 0.75 blue: 0.56 alpha: 1.0];
    self.commentsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.commentsImageView.image = [[UIImage imageNamed: @"icon-chat"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.profileImageView.layer.cornerRadius = 25;
    
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 18];
    
    self.locationLabel.textColor = [UIColor whiteColor];
    self.locationLabel.font = [UIFont fontWithName: MegaTheme.fontName size: 11];
    
    self.commentsLabel.textColor = [UIColor whiteColor];
    self.commentsLabel.font = [UIFont fontWithName: MegaTheme.fontName size: 11];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
