//
//  City.h
//  Plist
//
//  Created by 周俊杰 on 15/2/10.
//  Copyright (c) 2015年 北京金溪欣网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property (nonatomic , copy) NSString *city;
@property (nonatomic , strong) NSArray *areaArray;

- (instancetype)initWithDic:(NSDictionary *)infoDic;
@end
