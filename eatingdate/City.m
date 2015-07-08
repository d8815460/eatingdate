//
//  City.m
//  Plist
//
//  Created by 周俊杰 on 15/2/10.
//  Copyright (c) 2015年 北京金溪欣网络科技有限公司. All rights reserved.
//

#import "City.h"

@implementation City
- (instancetype)initWithDic:(NSDictionary *)infoDic {
    if (self = [super init]) {
        self.city = [infoDic objectForKey:@"city"];
        self.areaArray = [infoDic objectForKey:@"areas"];
    }
    return self;
}

@end
