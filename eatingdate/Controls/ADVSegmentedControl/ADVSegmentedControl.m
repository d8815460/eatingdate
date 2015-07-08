//
//  ADVSegmentedControl.m
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ADVSegmentedControl.h"
#import "MegaTheme.h"

@implementation ADVSegmentedControl



-(void)setItems:(NSArray *)items
{
    _items = items;
    [self setupLabels];
}

-(void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    [self displayNewSelectedIndex];
}

-(void)setSelectedLabelColor:(UIColor *)selectedLabelColor
{
    _selectedLabelColor = selectedLabelColor;
    
    [self setSelectedColors];
}

-(void)setUnselectedLabelColor:(UIColor *)unselectedLabelColor
{
    _unselectedLabelColor = unselectedLabelColor;
    
    [self setSelectedColors];
}

-(void)setThumbColor:(UIColor *)thumbColor
{
    _thumbColor = thumbColor;
    
    [self setSelectedColors];
}

-(void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
    
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    [self setFont];
}


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
    
    labels = [[NSMutableArray alloc] init];
    self.thumbView = [[UIView alloc] init];
    self.items = @[@"Item 1", @"Item 2", @"Item 3"];
    self.selectedIndex = 0;
    self.selectedLabelColor = [UIColor blackColor];
    self.unselectedLabelColor = [UIColor whiteColor];
    self.thumbColor = [UIColor whiteColor];
    self.borderColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:12];
    
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    self.layer.borderWidth = 2;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self setupLabels];

    [self addIndividualItemConstraints:labels mainView:self padding:0];
    
    [self insertSubview:self.thumbView atIndex:0];
}

-(void)setupLabels
{
    
    for(UILabel* label in labels) {
        [label removeFromSuperview];
    }
    
    [labels removeAllObjects];
    
    for (int index = 1; index < self.items.count+1; index++) {
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
        label.text = self.items[index - 1];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment =  NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:MegaTheme.boldFontName size: 15];
        label.textColor = index == 1 ? self.selectedLabelColor : self.unselectedLabelColor;
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:label];
        [labels addObject:label];
    }
    
    [self addIndividualItemConstraints:labels mainView:self padding:0];
}

-(void)layoutSubviews
{
 
    [super layoutSubviews];
    
    CGRect selectFrame = self.bounds;
    float newWidth = CGRectGetWidth(selectFrame) / self.items.count;
    selectFrame.size.width = newWidth;
    self.thumbView.frame = selectFrame;
    self.thumbView.backgroundColor = self.thumbColor;
    self.thumbView.layer.cornerRadius = self.thumbView.frame.size.height / 2;
    
    [self displayNewSelectedIndex];
    
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint location = [touch locationInView:self];
    
    int calculatedIndex = -1;
    
    for (int index = 0; index < labels.count; index++) {
        
        UILabel* item = [labels objectAtIndex:index];
        
        
        if (CGRectContainsPoint(item.frame, location)){
            
            calculatedIndex = index;
        }
        
    }
    
    
    if (calculatedIndex != -1) {
        
        self.selectedIndex = calculatedIndex;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    return NO;
}

-(void)displayNewSelectedIndex
{

    for (UILabel* item in labels ) {
        item.textColor = self.unselectedLabelColor;
    }
    
    
    UILabel* label = labels[self.selectedIndex];
    label.textColor = self.selectedLabelColor;
    
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.thumbView.frame = label.frame;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)addIndividualItemConstraints:(NSArray*)items mainView:(UIView*)mainView padding:(CGFloat)padding
{
    
    
    for (int index = 0 ; index < items.count ; index++) {
        
        UIView* button = items[index];
        
        NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem: button attribute: NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: mainView attribute: NSLayoutAttributeTop multiplier:1.0 constant:0];
        
        NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        
        NSLayoutConstraint* rightConstraint;
        
        if (index == items.count - 1) {
            
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeRight multiplier:1.0 constant: -padding];
            
        }else{
            
            UIButton* nextButton = items[index+1];
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nextButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant: -padding];
        }
        
        
        NSLayoutConstraint* leftConstraint;
        
        if (index == 0) {
            
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeLeft multiplier:1.0 constant: padding];
            
        }else{
            
            UIButton* prevButton = items[index-1];
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:prevButton attribute:NSLayoutAttributeRight multiplier:1.0 constant: padding];
            
            UIButton* firstItem = items[0];
            
            NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem:firstItem attribute: NSLayoutAttributeWidth multiplier:1.0 constant:0];
            
            [mainView addConstraint:widthConstraint];
        }
        
        [mainView addConstraints:@[topConstraint, bottomConstraint, rightConstraint, leftConstraint]];
    }
}

-(void)setSelectedColors
{
    
    for (UILabel* item in labels) {
        item.textColor = self.unselectedLabelColor;
    }
    
    if (labels.count > 0) {
        UILabel* label = labels[0];
        label.textColor = self.selectedLabelColor;
    }
    
    self.thumbView.backgroundColor = self.thumbColor;
}

-(void)setFont
{
    for(UILabel* item in labels)
    {
        item.font = self.font;
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
