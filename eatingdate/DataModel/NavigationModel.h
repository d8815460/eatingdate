//
//  NavigationModel.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationModel : NSObject

@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* icon;
@property(nonatomic, strong) NSString* count;


-(id)initWithTitle:(NSString*)title icon:(NSString*)icon;

-(id)initWithTitle:(NSString *)title icon:(NSString *)icon count:(NSString*)count;

@end
