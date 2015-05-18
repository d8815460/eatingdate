//
//  WriteTask.h
//  tw8
//
//  Created by ALEX on 2014/5/28.
//  Copyright (c) 2014年 miiitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface WriteTask : NSObject <NSCoding, NSCopying>

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
@property (nonatomic, strong) NSNumber * isTVIP;                //是否用TVIP身份發佈, O是false, 1=true

/*這裏以下是餐廳的類別
@property (nonatomic, strong) PFObject * category;              //餐廳類別
@property (nonatomic, strong) NSString * name;                  //餐廳名稱
@property (nonatomic, strong) NSString * address;               //餐廳地址
@property (nonatomic, strong) PFGeoPoint*geo;                   //餐廳經緯度
@property (nonatomic, strong) PFFile   * photoSmallFile;        //小照片
@property (nonatomic, strong) NSString * administrativeArea;    //餐廳所在縣市地區
@property (nonatomic, strong) NSString * city;                  //餐廳所在市區
@property (nonatomic, strong) NSString * phone;                 //餐廳電話
@property (nonatomic, strong) NSNumber * popularity;            //看過人數
@property (nonatomic, strong) NSNumber * howManyPeopleEat;      //吃過人數
@property (nonatomic, strong) NSString * minCost;               //最低消費
@property (nonatomic        ) BOOL       isPublic;              //餐廳是否公開
@property (nonatomic, strong) NSString * openHours;             //營業時間
@property (nonatomic, strong) NSString * commite;               //餐廳的介紹
*/

+(id)sharedWriteTask;

+(id)initWriteTasks;
@end
