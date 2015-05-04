//
//  ViewInfo.m
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ViewInfo.h"

@implementation ViewInfo


-(id)initWithTitle:(NSString *)title Segue:(NSString *)segue
{
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        
        self.segue = segue;
        
    }
    
    return self;
}

-(id)initWithTitle:(NSString *)title Segue:(NSString *)segue Description:(NSString *)description
{
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        
        self.segue = segue;
        
        self.view_description = description;
        
    }
    
    return self;
    
}

@end
