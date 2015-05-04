//
//  AccountViewController.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "AccountViewController.h"
#import "MegaTheme.h"
@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    
    bgImageView.image = [UIImage imageNamed: @"profile-bg"];
    profileImageView.image = [UIImage imageNamed: @"profile-pic-2"];
    profileImageView.layer.cornerRadius = 30;
    profileImageView.clipsToBounds = true;
    
    [self themeButtonWithText:editAvatarButton text: @"EDIT AVATAR"];
    [self themeButtonWithText:editBgButton text: @"EDIT BACKGROUND"];
    
    [self themeLabelWithText:nameLabel text: @"NAME"];
    [self themeTextFieldWithText:nameTextField text: @"Rachel Christofsson"];
    
    [self themeLabelWithText:locationLabel text: @"LOCATION"];
    [self themeTextFieldWithText:locationTextField text: @"London, UK"];
    
    [self themeLabelWithText:emailLabel text: @"EMAIL"];
    [self themeTextFieldWithText:emailTextField text: @"rachel@mail.com"];
    
    [self themeLabelWithText:passwordLabel text: @"PASSWORD"];
    [self themeTextFieldWithText:passwordTextField text: @"qowqoqooq"];
    passwordTextField.secureTextEntry = YES;
    
    [self themeLabelWithText:pushLabel text: @"PUSH NOTIFICATIONS"];
    [self themeLabelWithText:facebookLabel text: @"LOGGED IN WITH FACEBOOK"];
    
    [self themeButtonWithText:facebookButton text: @"LOGOUT"];
    facebookButton.tintColor =  [UIColor colorWithRed:0.19 green:0.38 blue:0.73 alpha:1.0];
    
    facebookImageView.image = [UIImage imageNamed: @"fb"];
    
    UIImage* doneImage = [[UIImage imageNamed: @"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [doneButton setImage:doneImage forState: UIControlStateNormal];
    doneButton.tintColor = [UIColor whiteColor];
    
    [self addBlurView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        return 150;
    }else if (indexPath.row == 5){
        return 15;
    }else{
        return 44;
    }
}


-(void)themeButtonWithText:(UIButton*)button text:(NSString*)text
{
    UIImage* background = [[UIImage imageNamed:@"border-button"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UIImage* backgroundTemplate = [background imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [button setBackgroundImage:backgroundTemplate forState: UIControlStateNormal];
    [button setTitle:text forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 11];
    button.tintColor = [UIColor whiteColor];
}

-(void) themeTextFieldWithText:(UITextField*)textField text:(NSString*)text
{
    CGFloat largeFontSize = 17;
    textField.font = [UIFont fontWithName:MegaTheme.lighterFontName size: largeFontSize];
    textField.textColor = MegaTheme.darkColor;
    textField.text = text;
    textField.delegate = self;
}

-(void) themeLabelWithText:(UILabel*)label text:(NSString*)text
{
    
    CGFloat fontSize = 10;
    label.font = [UIFont fontWithName:MegaTheme.boldFontName size: fontSize];
    label.textColor = MegaTheme.darkColor;
    label.text = text;
}

-(void) addBlurView
{
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.frame = CGRectMake(0, 0, 600, 100);
    
    [blurView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [profileContainer insertSubview:blurView aboveSubview: bgImageView];
    

    
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem: profileContainer attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: blurView attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 0.0];
    
    NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem: profileContainer attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: blurView attribute: NSLayoutAttributeBottom multiplier: 1.0 constant: 0.0];
    
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem: profileContainer attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual toItem: blurView attribute: NSLayoutAttributeLeft multiplier: 1.0 constant: 0.0];
    
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem: profileContainer attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual toItem: blurView attribute: NSLayoutAttributeRight multiplier: 1.0 constant: 0.0];
    
    [profileContainer addConstraints:@[topConstraint, rightConstraint, leftConstraint, bottomConstraint]];
}

-(void)doneTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deregisterFromKeyboardNotifications];
}

-(void)registerForKeyboardNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name: UIKeyboardDidShowNotification object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyboardWillBeHidden:) name: UIKeyboardWillHideNotification object: nil];
}

-(void) deregisterFromKeyboardNotifications
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWasShown:(NSNotification*)notification
{
    
    NSDictionary* info = notification.userInfo;
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets insets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardSize.height, 0);
    
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    
    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y + keyboardSize.height);
}

-(void)keyboardWillBeHidden:(NSNotification*)notification {
    
    NSDictionary* info = notification.userInfo;
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets insets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardSize.height, 0);
    
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)viewDidLayoutSubviews
{
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
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
