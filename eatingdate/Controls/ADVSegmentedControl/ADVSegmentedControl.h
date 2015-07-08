//
//  ADVSegmentedControl.h
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ADVSegmentedControl : UIControl
{
    NSMutableArray* labels;
}

@property(nonatomic, strong) UIView* thumbView;

@property(nonatomic, strong) NSArray* items;

@property(nonatomic) int selectedIndex;

@property(nonatomic, strong) IBInspectable UIColor* selectedLabelColor;

@property(nonatomic, strong) IBInspectable UIColor* unselectedLabelColor;

@property(nonatomic, strong) IBInspectable UIColor* thumbColor;

@property(nonatomic, strong) IBInspectable UIColor* borderColor;

@property(nonatomic, strong) IBInspectable UIFont* font;

@end
