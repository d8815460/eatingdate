//
//  EventModel.m
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel

-(id)initWithTitle:(NSString *)title type:(NSString *)type time:(NSString *)time description:(NSString *)description
{
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        
        self.type = type;
        
        self.time = time;
        
        self.eventDescription = description;
    }
    
    return self;
    
}

@end
