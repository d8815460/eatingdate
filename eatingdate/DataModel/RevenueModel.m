//
//  RevenueModel.m
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "RevenueModel.h"

@implementation RevenueModel

-(instancetype)initWithTitle:(NSString *)title percent:(CGFloat)percent startColor:(UIColor *)startColor endColor:(UIColor *)endColor
{
    self = [super init];
    
    if (self) {

        self.title = title;
        self.percent = percent;
        self.startColor = startColor;
        self.endColor = endColor;
        
    }
    
    return self;
    
}

@end
