//
//  LeftMenuViewController.h
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/7/2.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuLeftTableViewController.h"

@interface LeftMenuViewController : AMSlideMenuLeftTableViewController

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UIButton *postButton;
@property (strong, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *messengerButton;
@property (strong, nonatomic) IBOutlet UILabel *messagerLabel;
@property (strong, nonatomic) IBOutlet UIButton *heartButton;
@property (strong, nonatomic) IBOutlet UILabel *heartLabel;
@property (strong, nonatomic) IBOutlet UIButton *historyButton;
@property (strong, nonatomic) IBOutlet UILabel *historyLabel;
@property (strong, nonatomic) IBOutlet UIButton *gvipButton;
@property (strong, nonatomic) IBOutlet UILabel *gvipLabel;
@property (strong, nonatomic) IBOutlet UIButton *tvipButton;
@property (strong, nonatomic) IBOutlet UILabel *tvipLabel;
@property (strong, nonatomic) IBOutlet UIButton *pointButton;
@property (strong, nonatomic) IBOutlet UILabel *pointLabel;
@property (strong, nonatomic) IBOutlet UIButton *settingButton;
@property (strong, nonatomic) IBOutlet UILabel *settingLabel;

- (IBAction)dateButtonPressed:(id)sender;
- (IBAction)messengerButtonPressed:(id)sender;
- (IBAction)heartButtonPressed:(id)sender;
- (IBAction)historyButtonPressed:(id)sender;
- (IBAction)gvipButtonPressed:(id)sender;
- (IBAction)tvipButtonPressed:(id)sender;
- (IBAction)pointButtonPressed:(id)sender;
- (IBAction)settingButtonPressed:(id)sender;


- (IBAction)feedbackButtonPressed:(id)sender;
- (IBAction)termOfServiceButtonPressed:(id)sender;


@end
