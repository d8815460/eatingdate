//
//  NavigationTableCell.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationTableCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel* titleLabel;
@property(nonatomic, strong) IBOutlet UILabel* countLabel;
@property(nonatomic, strong) IBOutlet UIView* countContainer;

@end
