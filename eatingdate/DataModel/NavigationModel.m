//
//  NavigationModel.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "NavigationModel.h"

@implementation NavigationModel

-(id)initWithTitle:(NSString *)title icon:(NSString *)icon
{
    self = [super init];
    
    if (self) {
        
        self.title = title;
        
        self.icon = icon;
        
    }
    
    return self;
    
}

-(id)initWithTitle:(NSString *)title icon:(NSString *)icon count:(NSString *)count
{
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        
        self.icon = icon;
        
        self.count = count;
        
    }
    
    return self;
    
}

@end
