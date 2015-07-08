//
//  ADVGradientButton.h
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ADVGradientButton : UIButton

@property(nonatomic,strong) CAGradientLayer* gradientLayer;

@property(nonatomic,strong) IBInspectable UIColor* gradientStart;

@property(nonatomic,strong) IBInspectable UIColor* gradientEnd;

@end
