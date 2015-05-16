//
//  PictureListViewController.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVTabSegmentControl.h"
#import "DKCircleButton.h"

@interface PictureListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    NSArray* people;

}
@property(nonatomic, strong) IBOutlet ADVTabSegmentControl* tabSegmentControl;
@property(nonatomic, strong) IBOutlet UITableView* tableView;
- (IBAction)postButtonPressed:(id)sender;

@end
