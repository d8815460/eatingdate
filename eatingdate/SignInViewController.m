//
//  SignInViewController.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SignInViewController.h"
#import "MegaTheme.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bgImageView.image = [UIImage imageNamed:@"nav-bg-2"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    titleLabel.text = @"Sign In";
    titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 45];
    titleLabel.textColor = [UIColor whiteColor];
    
    [twitterButton setTitle:@"Sign in with Twitter" forState: UIControlStateNormal];
    [twitterButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    twitterButton.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 15];
    twitterButton.backgroundColor = [UIColor colorWithRed:0.23 green: 0.43 blue: 0.88 alpha: 1.0];
    [twitterButton addTarget:self action:@selector(dismiss) forControlEvents: UIControlEventTouchUpInside];
    
    [facebookButton setTitle:@"Sign in with Facebook" forState: UIControlStateNormal];
    [facebookButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    facebookButton.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 16];
    facebookButton.backgroundColor = [UIColor colorWithRed:0.21 green: 0.30 blue: 0.55 alpha: 1.0];
    [facebookButton addTarget:self action:@selector(dismiss) forControlEvents: UIControlEventTouchUpInside];
    
    
    NSMutableAttributedString* attributedText = [[NSMutableAttributedString alloc] initWithString:@"Don't have an account? Sign up"];
    
    
    [attributedText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(10, 7)];
    
    
    [attributedText addAttribute:NSForegroundColorAttributeName value: [UIColor whiteColor] range: NSMakeRange(0, attributedText.length)];
    
    [noAccountButton setAttributedTitle:attributedText forState: UIControlStateNormal];
    [noAccountButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    noAccountButton.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size:14];
    [noAccountButton addTarget:self action:@selector(dismiss) forControlEvents: UIControlEventTouchUpInside];
    
    [signInButton setTitle:@"Sign In" forState: UIControlStateNormal];
    [signInButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    signInButton.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 22];
    signInButton.layer.borderWidth = 3;
    signInButton.layer.borderColor = [UIColor whiteColor].CGColor;
    signInButton.layer.cornerRadius = 5;
    [signInButton addTarget:self action:@selector(dismiss) forControlEvents: UIControlEventTouchUpInside];
    
    [forgotPassword setTitle:@"Forgot Password?" forState: UIControlStateNormal];
    [forgotPassword setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    forgotPassword.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 15];
    [forgotPassword addTarget:self action:@selector(dismiss) forControlEvents: UIControlEventTouchUpInside];
    
    passwordContainer.backgroundColor = [UIColor clearColor];
    
    passwordLabel.text = @"Password";
    passwordLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 20];
    passwordLabel.textColor = [UIColor whiteColor];
    
    passwordTextField.text = @"";
    passwordTextField.font = [UIFont fontWithName:MegaTheme.fontName size: 20];
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.secureTextEntry = YES;
    
    userContainer.backgroundColor = [UIColor clearColor];
    
    userLabel.text = @"Email";
    userLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 20];
    userLabel.textColor = [UIColor whiteColor];
    
    userTextField.text = @"";
    userTextField.font = [UIFont fontWithName:MegaTheme.fontName size: 20];
    userTextField.textColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
    titleLabel.hidden = newCollection.verticalSizeClass ==  UIUserInterfaceSizeClassCompact;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
