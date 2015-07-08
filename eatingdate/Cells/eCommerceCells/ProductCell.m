//
//  ProductCell.m
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ProductCell.h"
#import "MegaTheme.h"
@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
    
    self.titleLabel.font =[UIFont fontWithName:[MegaTheme fontName] size:14];
    
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.priceLabel.font = [UIFont fontWithName:[MegaTheme fontName] size:10];
    
    self.priceLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    self.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    
    self.layer.borderWidth = 0.3;
    
    self.blurViewFrame = self.blurView.frame;

    
}

-(void)setCellSelected:(BOOL)selected
{
    
    if (selected) {

        self.blurViewFrame = self.blurView.frame;
        
        CGRect frame = self.frame;
        
        frame.origin = CGPointMake(0, 0);

        [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.blurView.frame = frame;
            
        } completion:^(BOOL finished) {
            
        }];
        
        
        
    }else{
        
        [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.blurView.frame = self.blurViewFrame;
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    
    
}

@end
