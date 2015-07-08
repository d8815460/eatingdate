//
//  ADVGradientButton.m
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ADVGradientButton.h"

@implementation ADVGradientButton


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupView];
        
    }
    
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setupView];
        
    }
    
    return self;
}

-(void)setupView
{
    
    
    self.gradientLayer =[CAGradientLayer layer];
    
    self.gradientStart = [UIColor colorWithRed:0.22 green: 0.64 blue: 0.89 alpha: 1.0];
    
    self.gradientEnd = [UIColor colorWithRed:0.25 green:0.83 blue:0.73 alpha: 1.0];
  
    
    self.gradientLayer.frame = self.bounds;

    self.gradientLayer.colors = @[(id)self.gradientStart.CGColor, (id)self.gradientEnd.CGColor];
    self.gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    self.gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    [self.layer insertSublayer:self.gradientLayer atIndex: 0];
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.gradientLayer.frame = self.bounds;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
