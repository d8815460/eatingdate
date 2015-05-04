//
//  AccountViewController.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuRightTableViewController.h"

@interface AccountViewController : AMSlideMenuRightTableViewController <UITextFieldDelegate>
{
    IBOutlet UIImageView* profileImageView;
    IBOutlet UIButton* editBgButton ;
    IBOutlet UIButton* editAvatarButton;
    
    IBOutlet UIImageView* bgImageView;
    IBOutlet UIView* profileContainer;
    IBOutlet UIButton* doneButton;
    
    IBOutlet UILabel* nameLabel;
    IBOutlet UITextField* nameTextField;
    IBOutlet UILabel* locationLabel;
    IBOutlet UITextField* locationTextField;
    IBOutlet UILabel* emailLabel;
    IBOutlet UITextField* emailTextField;
    IBOutlet UILabel* passwordLabel;
    IBOutlet UITextField* passwordTextField;
    
    IBOutlet UILabel* pushLabel;
    IBOutlet UISwitch* pushSwitch;
    IBOutlet UILabel* facebookLabel;
    IBOutlet UIImageView* facebookImageView;
    IBOutlet UIButton* facebookButton;

}

-(IBAction)doneTapped:(id)sender;
@end
