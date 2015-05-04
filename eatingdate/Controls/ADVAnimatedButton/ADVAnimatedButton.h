//
//  ADVAnimatedButton.h
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ADVAnimatedButton : UIButton
{
    
    UIImageView* refreshImageView;
    
    BOOL animating;
    
    
    
}

@property(nonatomic, strong) IBInspectable UIImage* imageToShow;


-(void)startAnimating;

-(void)stopAnimating;

@end
