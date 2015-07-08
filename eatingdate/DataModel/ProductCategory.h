//
//  ProductCategory.h
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCategory : NSObject

@property(nonatomic, strong) NSString* title;

@property(nonatomic, strong) NSString* count;

@property(nonatomic, strong) NSString* image;


-(id)initWithTitle:(NSString*) title Count:(NSString*) count Image:(NSString*) image;

@end
