//
//  BuyPointViewController.h
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/7/5.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyPointViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *myPointLabel;
@property (strong, nonatomic) IBOutlet UILabel *myPointDescLabel;
- (IBAction)buy1Point:(id)sender;
- (IBAction)buy2Point:(id)sender;
- (IBAction)buy3Point:(id)sender;
- (IBAction)buy4Point:(id)sender;

@end
