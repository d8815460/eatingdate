//
//  UIKeyboardCoViewForMessenger.h
//  taiwan8
//
//  Created by ALEX on 2014/10/4.
//  Copyright (c) 2014年 taiwan8. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIKeyboardCoViewForMessengerDelegate;


/**
 Notification to post in the ROOT view controller when the view has rotated. KeyboardCoViews need this in order to manage the rotation correctly
 */
#define UIKeyboardCoViewWillRotateNotification @"UIKeyboardCoViewWillRotateNotification"

/**
 Notification to post in the ROOT view controller when the view did rotate. KeyboardCoViews need this in order to manage the rotation correctly
 */
#define UIKeyboardCoViewDidRotateNotification @"UIKeyboardCoViewDidRotateNotification"










/**
	This class is a subclass of UIView that stays on top of the keyboard. For best results, the view in the XIB should be HIDDEN at first.
 
 In order for this view to work correctly with rotation, the ROOT view controller has to post the UIKeyboardCoViewWillRotateNotification and UIKeyboardCoViewDidRotateNotification in the willRotateToInterfaceOrientation and didRotateFromInterfaceOrientation respectively. Like so:
 
 - (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
 [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardCoViewWillRotateNotification object:nil];
 }
 
 - (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
 [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardCoViewDidRotateNotification object:nil];
 }
 
 */


@interface UIKeyboardCoViewForMessenger : UIView
@property (nonatomic,assign) IBOutlet id<UIKeyboardCoViewForMessengerDelegate> delegate;
@end

/**
 Protocol to implement for a UIKeyboardCoView delegate
 */
@protocol UIKeyboardCoViewForMessengerDelegate <NSObject>



@optional
/**
 Called when the Keyboard Co View will appear
 @param keyboardCoView The keyboard co view that will appear
 */
- (void) keyboardCoViewWillAppear:(UIKeyboardCoViewForMessenger *)keyboardCoView;

/**
 Called when the Keyboard Co View did appear
 @param keyboardCoView The keyboard co view that did appear
 */
- (void) keyboardCoViewDidAppear:(UIKeyboardCoViewForMessenger *)keyboardCoView;
/**
 Called when the Keyboard Co View will disappear
 @param keyboardCoView The keyboard co view that will disappear
 */
- (void) keyboardCoViewWillDisappear:(UIKeyboardCoViewForMessenger *)keyboardCoView;
/**
 Called when the Keyboard Co View did disappear
 @param keyboardCoView The keyboard co view that did disappear
 */
- (void) keyboardCoViewDidDisappear:(UIKeyboardCoViewForMessenger *)keyboardCoView;

@end
