//
//  PhotoCell.m
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "PhotoCell.h"
#import "MegaTheme.h"
@implementation PhotoCell

-(void)awakeFromNib
{
    self.iconImageView.image = [UIImage imageNamed:@"icon-camera"];
    
    self.countLabel.textColor = UIColor.whiteColor;
    self.countLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 11];

}

@end
