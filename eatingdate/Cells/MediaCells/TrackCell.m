//
//  TrackCell.m
//  Mega
//
//  Created by MMStart on 11/03/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "TrackCell.h"
#import "MegaTheme.h"

@implementation TrackCell

- (void)awakeFromNib {
    // Initialization code
    self.playImage.image = [[UIImage imageNamed:@"media-play"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.playImage.tintColor = [UIColor whiteColor];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont fontWithName:MegaTheme.fontName size:13];
    
    self.durationLabel.textColor = [UIColor whiteColor];
    self.durationLabel.font = [UIFont fontWithName:MegaTheme.fontName size:13];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    UIImage *image = [[UIImage imageNamed:@"media-play"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (selected) {
        image = [UIImage imageNamed:@"media-equalizer"];
    }
    
    self.playImage.image = image;
}

@end
