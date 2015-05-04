//
//  EventCell.m
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "EventCell.h"
#import "MegaTheme.h"
@implementation EventCell

- (void)awakeFromNib {
    // Initialization code
    
    self.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 18];
    self.titleLabel.textColor = UIColor.blackColor;
    
    self.timeLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 16];
    self.timeLabel.textColor = [UIColor colorWithRed:0.39 green: 0.26 blue: 0.82 alpha: 1.0];
    
    self.descriptionLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 12];
    self.descriptionLabel.textColor = [UIColor colorWithWhite:0.70 alpha: 1.0];
    
}

@end
