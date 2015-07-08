//
//  ConnectionCell.m
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ConnectionCell.h"
#import "MegaTheme.h"
@implementation ConnectionCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 15];
    self.titleLabel.textColor = [UIColor blackColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
