//
//  EventModel.h
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property(nonatomic,strong) NSString* title;

@property(nonatomic,strong) NSString* type;

@property(nonatomic,strong) NSString* time;

@property(nonatomic,strong) NSString* eventDescription;


-initWithTitle:(NSString*)title type:(NSString*)type time:(NSString*)time description:(NSString*)description;

@end
