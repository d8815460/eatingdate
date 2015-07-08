//
//  Album.h
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "Track.h"

@interface Album : NSObject

@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* coverImageUrl;
@property(nonatomic, strong) NSString* artist;
@property(nonatomic) int songCount;
@property(nonatomic, strong) NSMutableArray* tracks;

- (instancetype)initWithTitle:(NSString*)title artist:(NSString*)artist coverImageUrl:(NSString*)coverImageUrl songCount:(int) songCount;

@end
