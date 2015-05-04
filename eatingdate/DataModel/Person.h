//
//  Person.h
//  Mega
//
//  Created by Sergey on 2/2/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* profilePicUrl;
@property(nonatomic, strong) NSString* backgroundPicUrl;
@property(nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *years;
@property(nonatomic, strong) NSString* location;
@property(nonatomic, strong) NSString* commentCount;
@property (nonatomic, strong) NSString *restaurant;

-(instancetype)initWithName:(NSString*)name profilePicUrl:(NSString*)profilePicUrl backgroundPicUrl:(NSString*)backgroundPicUrl sex:(NSString *)sex years:(NSString *)years location:(NSString*)location commentCount:(NSString*)commentCount restaurant:(NSString *)restaurant;

@end
