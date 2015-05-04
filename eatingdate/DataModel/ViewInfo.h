//
//  ViewInfo.h
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewInfo : NSObject

@property (nonatomic, strong) NSString*  title;

@property (nonatomic, strong) NSString*  segue;

@property (nonatomic, strong) NSString*  view_description;


-(id)initWithTitle : (NSString*) title Segue:(NSString*) segue;

-(id)initWithTitle:(NSString *)title Segue:(NSString *)segue Description:(NSString*)description;

@end
