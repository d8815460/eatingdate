//
//  SignInViewController.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
{
    IBOutlet UILabel* titleLabel;
    
    IBOutlet UIButton* facebookButton;
    IBOutlet UIButton* twitterButton;
    
    IBOutlet UIImageView* bgImageView;
    
    IBOutlet UIButton* noAccountButton;
    IBOutlet UIButton* signInButton;
    
    IBOutlet UIButton* forgotPassword;
    
    IBOutlet UIView* passwordContainer;
    IBOutlet UILabel* passwordLabel;
    IBOutlet UITextField* passwordTextField;
    IBOutlet UIView* passwordUnderline;
    
    IBOutlet UIView* userContainer;
    IBOutlet UILabel* userLabel;
    IBOutlet UITextField* userTextField;
    IBOutlet UIView* userUnderline;

}
@end
