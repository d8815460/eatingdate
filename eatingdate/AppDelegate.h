//
//  AppDelegate.h
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/1.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MinnaNotificationProtocol.h"
#import <CoreLocation/CoreLocation.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, CLLocationManagerDelegate, MinnaListenerServerProtocol>{
    // Minna in APP notification
    // used to store ID -> Listener
    NSMutableDictionary *minnaNotificationDictionary;
    
    // store MinnaOpenGraphRequest
    NSMutableArray *minnaOpenGraphQueue;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//轉場至首頁
- (void)presentToHomePage;
@end

