//
//  NavigationSideCell.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "NavigationSideCell.h"

@implementation NavigationSideCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    if(selected){
        self.selectIndicator.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    }else{
        self.selectIndicator.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    }
    
}

@end
