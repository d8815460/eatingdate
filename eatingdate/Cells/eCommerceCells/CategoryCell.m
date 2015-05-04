//
//  CategoryCell.m
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "CategoryCell.h"

#import "MegaTheme.h"

@implementation CategoryCell

-(void)awakeFromNib
{
    
    self.titleLabel.font = [UIFont fontWithName:[MegaTheme fontName] size:13];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.countLabel.font = [UIFont fontWithName:[MegaTheme fontName] size:13];

    self.countLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    
    self.alphaView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    
}

@end
