//
//  RevenueModel.h
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RevenueModel : NSObject

@property(nonatomic) CGFloat percent;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) UIColor* startColor;
@property(nonatomic, strong) UIColor* endColor;

-(instancetype)initWithTitle:(NSString*)title percent:(CGFloat)percent startColor:(UIColor*)startColor endColor:(UIColor*)endColor;

@end
