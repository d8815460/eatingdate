//
//  AlbumCell.m
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "AlbumCell.h"
#import "MegaTheme.h"
@implementation AlbumCell

-(void)awakeFromNib
{
    self.artistLabel.textColor = UIColor.blackColor;
    self.artistLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 18];
    
    self.titleLabel.textColor = [UIColor colorWithWhite:0.45 alpha: 1.0];
    self.titleLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 14];
    
    self.songCountLabel.textColor = [UIColor colorWithRed:0.33 green: 0.62 blue: 0.94 alpha: 1.0];
    self.songCountLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 11];
    
}

@end
