//
//  ADVTabSegmentControl.m
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ADVTabSegmentControl.h"
#import "MegaTheme.h"
@implementation ADVTabSegmentControl



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

-(void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setSelectedColors];
}
-(void)setFont:(UIFont *)font
{
    _font = font;
    [self setFont];
}


-(void)setupView
{
    
    labels = [[NSMutableArray alloc] init];
    separators = [[NSMutableArray alloc] init];
    _items = [[NSArray alloc] init];
    _items = @[@"Item 1", @"Item 2", @"Item 3"];
    _selectedIndex = 0;
    _selectedLabelColor  = [UIColor blackColor];
    _unselectedLabelColor = [UIColor colorWithWhite:0.47 alpha: 1.0];
    _borderColor = [UIColor colorWithWhite: 0.78 alpha: 1.0];
    _font = [UIFont systemFontOfSize:12];
    
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = 0.5;
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha: 1.0];
    
    [self setupLabels];
    
    [self addIndividualItemConstraintsItems:labels mainView: self padding: 0];
    
}

-(void) setupLabels
{
    
    for(UILabel* label in labels ){
        
        [label removeFromSuperview];
        
    }
    
    [labels removeAllObjects];
    
    for (int index = 1 ; index < self.items.count+1 ; index++) {
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
        label.text = self.items[index - 1];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName: MegaTheme.boldFontName size: 15];
        label.textColor = index == 1 ? self.selectedLabelColor : self.unselectedLabelColor;
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:label];
        [labels addObject:label];
        
        //Add separators unless we are at the last label
        if (index != self.items.count) {
            UIView* separator = [[UIView alloc] init];
            separator.backgroundColor = self.borderColor;
            [separator setTranslatesAutoresizingMaskIntoConstraints:NO];
            [separators addObject:separator];
            [self addSubview:separator];
        }
    }
    
    [self addIndividualItemConstraintsItems:labels mainView: self padding: 0];
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
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
    
    for (UILabel* item in labels) {
        
        item.textColor = self.unselectedLabelColor;
        
    }
    
    UILabel* label = labels[self.selectedIndex];
    label.textColor = self.selectedLabelColor;
    
}

-(void) addIndividualItemConstraintsItems:(NSArray*)items mainView:(UIView*)mainView padding:(CGFloat)padding
{
    
    for (int index = 0 ; index < items.count ; index++) {
       
        UIView* button = items[index];
        
        NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:button attribute: NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: mainView attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 0];
        
        NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: mainView attribute:NSLayoutAttributeBottom multiplier: 1.0 constant: 0];
        
        NSLayoutConstraint* rightConstraint;
        
        if (index == items.count - 1) {
            
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual toItem: mainView attribute: NSLayoutAttributeRight multiplier: 1.0 constant: -padding];
            
        }else{
            
            UIView* nextSeparator = separators[index];
            
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem: nextSeparator attribute:NSLayoutAttributeLeft multiplier: 1.0 constant: -padding];
        }
        
        
        NSLayoutConstraint* leftConstraint;
        
        if (index == 0) {
            
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute: NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: mainView attribute:NSLayoutAttributeLeft multiplier: 1.0 constant: padding];
            
        }else{
            
            UIView* previousSeparator = separators[index - 1];
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: previousSeparator attribute:NSLayoutAttributeRight multiplier: 1.0 constant: padding];
            
            UIView* firstItem = items[0];
            
            NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem: firstItem attribute:NSLayoutAttributeWidth multiplier: 1.0 constant: 0];
            
            [mainView addConstraint:widthConstraint];
        }
        
        [mainView addConstraints:@[topConstraint, bottomConstraint, rightConstraint, leftConstraint]];
    }
    
    for (UIView* separator in separators) {
        
        NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:separator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem: nil attribute:NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 0.5];
        
        [separator addConstraint:widthConstraint];
        
        NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:separator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: mainView attribute:NSLayoutAttributeTop multiplier: 1.0 constant: 10];
        
        NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem:separator attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: mainView attribute:NSLayoutAttributeBottom multiplier: 1.0 constant: -10];
        
        [mainView addConstraints:@[topConstraint, bottomConstraint]];
    }
    
}


-(void)setSelectedColors
{
    for(UILabel* item in labels) {
        item.textColor = self.unselectedLabelColor;
    }
    
    if (labels.count > 0) {
        
        UILabel* label = labels[0];
        label.textColor = self.selectedLabelColor;
    }
    
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = 1;
    
}


-(void)setFont{
    for (UILabel*item in labels) {
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
