//
//  ADVAnimatedButton.m
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ADVAnimatedButton.h"

@implementation ADVAnimatedButton


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


-(void)setImageToShow:(UIImage *)imageToShow
{
    
    _imageToShow = imageToShow;
    
    refreshImageView.image = [imageToShow imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
}

-(void)setupView
{

    refreshImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    animating = NO;
    
    self.imageToShow = [UIImage imageNamed:@"sync"];
    
    
    refreshImageView.image = [[UIImage imageNamed:@"sync"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    
    refreshImageView.tintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    [refreshImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:refreshImageView];
    
}

-(void)layoutSubviews
{
  
    [super layoutSubviews];
    
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:refreshImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeHeight  multiplier:1.0 constant: 0.0];
    
    NSLayoutConstraint* aspectRatioConstraint = [NSLayoutConstraint constraintWithItem:refreshImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:refreshImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant: 0.0];
    
    NSLayoutConstraint* horizontalSpacingConstraint = [NSLayoutConstraint constraintWithItem:refreshImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant: -10.0];
    
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:refreshImageView attribute: NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute: NSLayoutAttributeTop multiplier:1.0 constant: 0.0];
    
    [refreshImageView addConstraint:aspectRatioConstraint];
    
    [self addConstraints:@[heightConstraint, horizontalSpacingConstraint, topConstraint]];
    
    NSLayoutConstraint* horizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem:self attribute: NSLayoutAttributeCenterX multiplier:1.0 constant: 0.0];
    
    NSLayoutConstraint* verticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeCenterY multiplier: 1.0 constant: 0.0];
    
    [self addConstraints:@[horizontalCenterConstraint, verticalCenterConstraint]];
    
}

-(void)startAnimating
{
    
    if(!animating) {
        
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = [NSNumber numberWithDouble:M_PI * 2.0];
        animation.cumulative = YES;
        animation.duration = 1.0;
        animation.repeatCount = 10000;
        
        [refreshImageView.layer addAnimation:animation forKey:@"rotationAnimation"];
        
        animating = YES;
    }
}

-(void)stopAnimating{
    
    [CATransaction begin];
    
    [refreshImageView.layer removeAllAnimations];
    [CATransaction commit];
    animating = NO;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
