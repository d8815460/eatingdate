//
//  Album.m
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "Album.h"

@implementation Album

-(instancetype)initWithTitle:(NSString*)title artist:(NSString*)artist coverImageUrl:(NSString*)coverImageUrl songCount:(int) songCount
{
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        self.artist = artist;
        self.coverImageUrl = coverImageUrl;
        self.songCount = songCount;
        
    }
    
    return self;
    
}

@end
