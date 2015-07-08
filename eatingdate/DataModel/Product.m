//
//  Product.m
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithTitle:(NSString *)title Price:(NSString *)price Image:(NSString *)image
{
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        
        self.price = price;
        
        self.image = image;
        
    }
    
    return self;
    
}

@end
