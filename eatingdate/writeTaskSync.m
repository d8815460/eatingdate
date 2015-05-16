//
//  writeTaskSync.m
//  taiwan8
//
//  Created by ALEX on 2014/10/28.
//  Copyright (c) 2014年 taiwan8. All rights reserved.
//

#import "writeTaskSync.h"
#import "WriteTask.h"

@implementation writeTaskSync
@dynamic action;
@dynamic shareTime;
@dynamic objectId;
@dynamic fromUser;              //誰發起約會單
@dynamic dateType;              //約會形式（我請客，誰請我）
@dynamic dateTitle;             //約會主題
@dynamic picMedium;             //發布約會背景照片（大）
@dynamic picSmall;             //發布約會背景照片（小）
@dynamic restaurant;            //某一間餐廳
@dynamic dateTime;              //約會的時間
@dynamic restaurantCategory;    //餐廳類別
@dynamic restaurantName;        //餐廳名稱
@dynamic restaurantAddress;     //餐廳地址
@dynamic restaurantGeo;         //餐廳經緯度
@dynamic restaurantPhone;       //餐廳電話
@dynamic restaurantMinCost;     //最低消費
@dynamic gameType;              //屬於馬上約或指定約或發布約的遊戲規則
@dynamic peopleAskNumber;       //報名人數
@dynamic toUser;                //最後決定約會的人選
@dynamic postCost;              //約會單花費的信用額度


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
    [aCoder encodeObject:self.restaurantGeo         forKey:kDateRestaurantGeo];
    [aCoder encodeObject:self.restaurantPhone       forKey:kDateRestaurantPhone];
    [aCoder encodeObject:self.restaurantMinCost     forKey:kDateRestaurantMinCost];
    [aCoder encodeObject:self.gameType              forKey:kDateGameType];
    [aCoder encodeObject:self.peopleAskNumber       forKey:kDatePeopleAskNumber];
    [aCoder encodeObject:self.toUser                forKey:kDateToUser];
    [aCoder encodeObject:self.postCost              forKey:kDatePostCost];
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
        self.restaurantGeo      = [aDecoder decodeObjectForKey:kDateRestaurantGeo];
        self.restaurantPhone    = [aDecoder decodeObjectForKey:kDateRestaurantPhone];
        self.restaurantMinCost  = [aDecoder decodeObjectForKey:kDateRestaurantMinCost];
        self.gameType           = [aDecoder decodeObjectForKey:kDateGameType];
        self.peopleAskNumber    = [aDecoder decodeObjectForKey:kDatePeopleAskNumber];
        self.toUser             = [aDecoder decodeObjectForKey:kDateToUser];
        self.postCost           = [aDecoder decodeObjectForKey:kDatePostCost];
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
    another.restaurantGeo       = self.restaurantGeo;
    another.restaurantPhone     = self.restaurantPhone;
    another.restaurantMinCost   = self.restaurantMinCost;
    another.gameType        = self.gameType;
    another.peopleAskNumber     = self.peopleAskNumber;
    another.toUser          = self.toUser;
    another.postCost        = self.postCost;
    another.objectId        = self.objectId;
    another.objectId        = self.objectId;
    another.objectId        = self.objectId;
    return another;
}

@end
