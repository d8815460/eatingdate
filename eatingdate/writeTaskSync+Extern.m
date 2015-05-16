//
//  writeTaskSync+Extern.m
//  taiwan8
//
//  Created by ALEX on 2014/10/28.
//  Copyright (c) 2014年 taiwan8. All rights reserved.
//

#import "writeTaskSync+Extern.h"
#import "AppDelegate.h"

@implementation writeTaskSync (Extern)

+(writeTaskSync *)getUnsuncData{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"writeTaskSync" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"time" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    
    NSError *error = nil;
    NSArray *array = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    return [array firstObject];
}

@end
