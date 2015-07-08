//
//  MetaCell.m
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "MetaCell.h"

#import "MegaTheme.h"

@implementation MetaCell

- (void)awakeFromNib {
    
    // Initialization code
    
    self.titleLabel.font = [UIFont fontWithName:[MegaTheme fontName] size:15];
    
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.subtitleLabel.font = [UIFont fontWithName:[MegaTheme fontName] size:12];
    
    self.subtitleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
