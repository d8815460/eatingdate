//
//  writeTaskSync.h
//  taiwan8
//
//  Created by ALEX on 2014/10/28.
//  Copyright (c) 2014年 taiwan8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface writeTaskSync : NSManagedObject
@property (nonatomic, retain) NSNumber * action;
@property (nonatomic, retain) NSDate * shareTime;
@property (nonatomic, strong) NSString * objectId;
@property (nonatomic, strong) PFObject * fromUser;              //誰發起約會單
@property (nonatomic, strong) NSString * dateType;              //約會形式（我請客，誰請我）
@property (nonatomic, strong) NSString * dateTitle;             //約會主題
@property (nonatomic, strong) PFFile   * picMedium;             //發布約會背景照片（大）
@property (nonatomic, strong) PFFile   * picSmall;             //發布約會背景照片（小）
@property (nonatomic, strong) PFObject * restaurant;            //某一間餐廳
@property (nonatomic, strong) NSDate   * dateTime;              //約會的時間
@property (nonatomic, strong) PFObject * restaurantCategory;    //餐廳類別
@property (nonatomic, strong) NSString * restaurantName;        //餐廳名稱
@property (nonatomic, strong) NSString * restaurantAddress;     //餐廳地址
@property (nonatomic, strong) PFGeoPoint*restaurantGeo;         //餐廳經緯度
@property (nonatomic, strong) NSString * restaurantPhone;       //餐廳電話
@property (nonatomic, strong) NSString * restaurantMinCost;     //最低消費
@property (nonatomic, strong) NSString * gameType;              //屬於馬上約或指定約或發布約的遊戲規則
@property (nonatomic, strong) NSNumber * peopleAskNumber;       //報名人數
@property (nonatomic, strong) PFObject * toUser;                //最後決定約會的人選
@property (nonatomic, strong) NSNumber * postCost;              //約會單花費的信用額度



@end
