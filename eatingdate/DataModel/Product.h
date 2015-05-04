//
//  Product.h
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) NSString* image;

@property (nonatomic, strong) NSString* price;

-(id)initWithTitle:(NSString*) title Price:(NSString*)price Image:(NSString*)image;

@end
