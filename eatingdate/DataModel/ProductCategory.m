//
//  ProductCategory.m
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ProductCategory.h"

@implementation ProductCategory

-(id)initWithTitle:(NSString *)title Count:(NSString *)count Image:(NSString *)image
{

    self = [super init];
    
    if (self) {
        
        self.title = title;
        
        self.count = count;
        
        self.image = image;
        
    }

    return self;
    
}


@end
