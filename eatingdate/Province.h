//
//  Province.h
//  Plist
//
//  Created by 周俊杰 on 15/2/10.
//  Copyright (c) 2015年 北京金溪欣网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject
@property (nonatomic , copy) NSString *province;
@property (nonatomic , strong) NSMutableArray *cityArray;
- (instancetype)initWithDic:(NSDictionary *)infoDic;
@end
