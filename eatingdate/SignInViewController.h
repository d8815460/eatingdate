//
//  SignInViewController.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <IQKeyboardManager.h>

@interface SignInViewController : UIViewController <UITextFieldDelegate, FBSDKGraphRequestConnectionDelegate>
{
    
    IBOutlet UIButton *facebookButton;
    IBOutlet UIButton *noAccountButton;
    IBOutlet UIButton *signInButton;
    IBOutlet UIButton *forgotPassword;
    IBOutlet UITextField *userTextField;
    IBOutlet UITextField *passwordTextField;

    IBOutlet UITextField *userText2Field;
    IBOutlet UITextField *passwordText2Field;
    IBOutlet UITextField *emailAddressTextField;

    
}
@property (nonatomic, assign) id<FBSDKGraphRequestConnectionDelegate> delegate;

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)signupButtonPressed:(id)sender;
- (IBAction)forgotPasswordButtonPressed:(id)sender;
- (IBAction)facebookLoginButtonPressed:(id)sender;

@end
