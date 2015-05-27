//
//  WriteTask.m
//  tw8
//
//  Created by ALEX on 2014/5/28.
//  Copyright (c) 2014年 miiitech. All rights reserved.
//

#import "WriteTask.h"
#import "MyFile.h"
#import "CMConstants.h"

@implementation WriteTask

+(id)sharedWriteTask{
    static WriteTask *sharedWriteTaskManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString *path = [MyFile filePath:WriteTaskFile isProjectFile:NO];
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            sharedWriteTaskManagerInstance = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            
        }
        else
        {
            sharedWriteTaskManagerInstance = [[self alloc] init];
            
        }
    });
    return sharedWriteTaskManagerInstance;
}

+(id)initWriteTasks{
    static WriteTask *sharedWriteTaskManagerInstance = nil;
    sharedWriteTaskManagerInstance = [[self alloc] init];
    return sharedWriteTaskManagerInstance;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.objectId              forKey:kDateObjectId];
    [aCoder encodeObject:self.fromUser              forKey:kDateFromUser];
    [aCoder encodeObject:self.dateType              forKey:kDateType];
    [aCoder encodeObject:self.dateTitle             forKey:kDateTitle];
    [aCoder encodeObject:self.picMedium             forKey:kDatePicMedium];
    [aCoder encodeObject:self.picSmall              forKey:kDatePicSmall];
    [aCoder encodeObject:self.restaurant            forKey:kDateRestaurant];
    [aCoder encodeObject:self.dateTime              forKey:kDateTime];
    [aCoder encodeObject:self.restaurantCategory    forKey:kDateRestaurantCategory];
    [aCoder encodeObject:self.restaurantName        forKey:kDateRestaurantName];
    [aCoder encodeObject:self.restaurantAddress     forKey:kDateRestaurantAddress];
    [aCoder encodeObject:self.administrativeArea    forKey:kDateRestaurantAdministrativeArea];
    [aCoder encodeObject:self.city                  forKey:kDateRestaurantCity];
    [aCoder encodeObject:self.restaurantGeo         forKey:kDateRestaurantGeo];
    [aCoder encodeObject:self.restaurantPhone       forKey:kDateRestaurantPhone];
    [aCoder encodeObject:self.restaurantMinCost     forKey:kDateRestaurantMinCost];
    [aCoder encodeObject:self.gameType              forKey:kDateGameType];
    [aCoder encodeObject:self.peopleAskNumber       forKey:kDatePeopleAskNumber];
    [aCoder encodeObject:self.toUser                forKey:kDateToUser];
    [aCoder encodeObject:self.postCost              forKey:kDatePostCost];
    [aCoder encodeObject:self.isTVIP                forKey:kIsTVIP];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.objectId       = [aDecoder decodeObjectForKey:kDateObjectId];
        self.fromUser       = [aDecoder decodeObjectForKey:kDateFromUser];
        self.dateType       = [aDecoder decodeObjectForKey:kDateType];
        self.dateTitle      = [aDecoder decodeObjectForKey:kDateTitle];
        self.picMedium      = [aDecoder decodeObjectForKey:kDatePicMedium];
        self.picSmall       = [aDecoder decodeObjectForKey:kDatePicSmall];
        self.restaurant     = [aDecoder decodeObjectForKey:kDateRestaurant];
        self.dateTime       = [aDecoder decodeObjectForKey:kDateTime];
        self.restaurantCategory = [aDecoder decodeObjectForKey:kDateRestaurantCategory];
        self.restaurantName     = [aDecoder decodeObjectForKey:kDateRestaurantName];
        self.restaurantAddress  = [aDecoder decodeObjectForKey:kDateRestaurantAddress];
        self.administrativeArea = [aDecoder decodeObjectForKey:kDateRestaurantAdministrativeArea];
        self.city               = [aDecoder decodeObjectForKey:kDateRestaurantCity];
        self.restaurantGeo      = [aDecoder decodeObjectForKey:kDateRestaurantGeo];
        self.restaurantPhone    = [aDecoder decodeObjectForKey:kDateRestaurantPhone];
        self.restaurantMinCost  = [aDecoder decodeObjectForKey:kDateRestaurantMinCost];
        self.gameType           = [aDecoder decodeObjectForKey:kDateGameType];
        self.peopleAskNumber    = [aDecoder decodeObjectForKey:kDatePeopleAskNumber];
        self.toUser             = [aDecoder decodeObjectForKey:kDateToUser];
        self.postCost           = [aDecoder decodeObjectForKey:kDatePostCost];
        self.isTVIP             = [aDecoder decodeObjectForKey:kIsTVIP];
    }
    return self;
}


-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    WriteTask *another = [[WriteTask alloc] init];
    another.objectId        = self.objectId;
    another.dateType        = self.dateType;
    another.dateTitle       = self.dateTitle;
    another.picMedium       = self.picMedium;
    another.picSmall        = self.picSmall;
    another.restaurant      = self.restaurant;
    another.dateTime        = self.dateTime;
    another.restaurantCategory  = self.restaurantCategory;
    another.restaurantName      = self.restaurantName;
    another.restaurantAddress   = self.restaurantAddress;
    another.administrativeArea  = self.administrativeArea;
    another.city                = self.city;
    another.restaurantGeo       = self.restaurantGeo;
    another.restaurantPhone     = self.restaurantPhone;
    another.restaurantMinCost   = self.restaurantMinCost;
    another.gameType        = self.gameType;
    another.peopleAskNumber     = self.peopleAskNumber;
    another.toUser          = self.toUser;
    another.postCost        = self.postCost;
    another.isTVIP          = self.isTVIP;
    
    return another;
}
@end
