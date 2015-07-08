//
//  NavigationTableCell.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "NavigationTableCell.h"
#import "MegaTheme.h"
@implementation NavigationTableCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = [UIFont fontWithName: MegaTheme.boldFontName size: 16];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.countLabel.font = [UIFont fontWithName: MegaTheme.boldFontName size: 13];
    self.countLabel.textColor =  [UIColor whiteColor];
    
    self.countContainer.backgroundColor = [UIColor colorWithRed:0.33 green:0.62 blue:0.94 alpha:1.0];
    self.countContainer.layer.cornerRadius = 15;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    BOOL countNotAvailable = self.countLabel.text == nil;
    
    self.countContainer.hidden = countNotAvailable;
    self.countLabel.hidden = countNotAvailable;

    // Configure the view for the selected state
}

@end
