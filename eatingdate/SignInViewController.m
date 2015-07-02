//
//  SignInViewController.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SignInViewController.h"
#import "MegaTheme.h"
#import <MBProgressHUD.h>
#import <FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface SignInViewController ()
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation SignInViewController
@synthesize hud = _hud;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[IQKeyboardManager sharedManager] setEnable:true];
    
    [facebookButton setTitle:NSLocalizedString(@"使用Facebook登入", "登入畫面") forState: UIControlStateNormal];
    [facebookButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    facebookButton.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 16];
    facebookButton.backgroundColor = [UIColor colorWithRed:0.21 green: 0.30 blue: 0.55 alpha: 1.0];
    facebookButton.layer.cornerRadius = 5;
    
    [noAccountButton setTitle:NSLocalizedString(@"註冊", "登入畫面") forState:UIControlStateNormal];
    [noAccountButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    noAccountButton.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size:16];
    
    [signInButton setTitle:NSLocalizedString(@"登入", "登入畫面") forState: UIControlStateNormal];
    [signInButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    signInButton.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 16];
    signInButton.layer.cornerRadius = 5;
    
    [forgotPassword setTitle:NSLocalizedString(@"忘記密碼？", "登入畫面") forState: UIControlStateNormal];
    [forgotPassword setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    forgotPassword.titleLabel.font = [UIFont fontWithName:MegaTheme.semiBoldFontName size: 14];
    
    passwordTextField.text = @"";
    passwordTextField.font = [UIFont fontWithName:MegaTheme.fontName size: 16];
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    passwordTextField.layer.borderColor = [UIColor blackColor].CGColor;
    passwordTextField.layer.borderWidth = 1;
    passwordTextField.layer.cornerRadius = 5;
    
    userTextField.text = @"";
    userTextField.font = [UIFont fontWithName:MegaTheme.fontName size: 16];
    userTextField.textColor = [UIColor blackColor];
    userTextField.layer.borderColor = [UIColor blackColor].CGColor;
    userTextField.layer.borderWidth = 1;
    userTextField.layer.cornerRadius = 5;
    userTextField.delegate = self;
    
    passwordText2Field.text = @"";
    passwordText2Field.font = [UIFont fontWithName:MegaTheme.fontName size: 16];
    passwordText2Field.textColor = [UIColor blackColor];
    passwordText2Field.secureTextEntry = YES;
    passwordText2Field.delegate = self;
    passwordText2Field.layer.borderColor = [UIColor blackColor].CGColor;
    passwordText2Field.layer.borderWidth = 1;
    passwordText2Field.layer.cornerRadius = 5;
    
    userText2Field.text = @"";
    userText2Field.font = [UIFont fontWithName:MegaTheme.fontName size: 16];
    userText2Field.textColor = [UIColor blackColor];
    userText2Field.layer.borderColor = [UIColor blackColor].CGColor;
    userText2Field.layer.borderWidth = 1;
    userText2Field.layer.cornerRadius = 5;
    userText2Field.delegate = self;
    
    emailAddressTextField.text = @"";
    emailAddressTextField.font = [UIFont fontWithName:MegaTheme.fontName size: 16];
    emailAddressTextField.textColor = [UIColor blackColor];
    emailAddressTextField.layer.borderColor = [UIColor blackColor].CGColor;
    emailAddressTextField.layer.borderWidth = 1;
    emailAddressTextField.layer.cornerRadius = 5;
    emailAddressTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//DismissKeyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

//密碼鍵盤按下Go == 按下登錄按鈕
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self loginButtonPressed:nil];
    return true;
}

- (IBAction)loginButtonPressed:(id)sender {
    [PFUser logInWithUsernameInBackground:userTextField.text password:passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                //直接轉場至首頁
                                                [[AppDelegate sharedDelegate] presentToHomePage];
                                            });
                                            
                                        } else {
                                            // The login failed. Check error to see why.
                                            
                                            NSString *message = error.userInfo[@"error"];
                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登錄時發生錯誤" message:message delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                                            [alertView show];
                                        }
                                    }];
}

- (IBAction)signupButtonPressed:(id)sender {
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    _hud.dimBackground = YES;
    _hud.labelText = NSLocalizedString(@"正在進行註冊", nil);
    
    PFUser *user = [PFUser user];
    
    if (emailAddressTextField.text.length > 0) {
        user.email    = emailAddressTextField.text;
    }

    user.username = userText2Field.text;
    user.password = passwordText2Field.text;
    
    NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", [user objectId]];
    [user setValue:privateChannelName forKey:kPAPUserPrivateChannelKey];
    
    /* OTP 部分 */
    //隨機亂碼
    int ValueCode = arc4random() % 9999;
    if (ValueCode < 1000) {
        ValueCode = arc4random() % 9999;
    }
    NSNumber *valueCodeNumber = [NSNumber numberWithInt:ValueCode];
    [user setObject:valueCodeNumber forKey:@"phoneCode"];
    [user setObject:userText2Field.text forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //第一次註冊，導航至同意協定頁面
            _hud.labelText = NSLocalizedString(@"註冊中", nil);
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //儲存用戶名稱
            [userDefaults setValue:userText2Field.text forKey:kCMUserNameString];
            [userDefaults setValue:privateChannelName forKey:kPAPUserPrivateChannelKey];
            [userDefaults synchronize];
            
            [PFUser currentUser].username = userText2Field.text;
            
            [[PFUser currentUser] setObject:privateChannelName forKey:kPAPUserPrivateChannelKey];
            
            PFACL *ACL = [PFACL ACL];
            [ACL setPublicReadAccess:YES];
            [PFUser currentUser].ACL = ACL;
            
            
            //執行雲端代碼
            NSString *number = @"number";
            NSString *phoneCode = @"phoneCode";
            
            NSString *userPhoneNumber = [NSString stringWithFormat:@"+886%@", userText2Field.text];
            
            //雲端代碼
            [PFCloud callFunctionInBackground:@"inviteWithTwilio" withParameters:@{number:userPhoneNumber, phoneCode:valueCodeNumber} block:^(id object, NSError *error) {
                if (!error) {
                    NSLog(@"簡訊已經送出");
                    
                    [MBProgressHUD hideHUDForView:self.view animated:NO];
                    
                    [self performSegueWithIdentifier:@"verified" sender:noAccountButton];
                }
            }];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSString *errorString = [error userInfo][@"error"];
            
            if ([[errorString substringToIndex:17] isEqualToString:@"the email address"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"電子信箱已經被註冊過", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"確定", nil) otherButtonTitles: nil];
                [alertView show];
            }else{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"電話號碼已經被註冊過", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"確定", nil) otherButtonTitles:nil] show];
            }
            
        }
    }];
}

- (IBAction)forgotPasswordButtonPressed:(id)sender {
    
}

- (IBAction)facebookLoginButtonPressed:(id)sender {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[@"public_profile", @"email", @"user_friends"];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    _hud.dimBackground = YES;
    _hud.labelText = NSLocalizedString(@"正在進行登錄", nil);
    
    // Login PFUser using facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登錄取消" message:@"您已經取消了Facebook登錄" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"確定", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登錄錯誤" message:error.localizedFailureReason delegate:nil cancelButtonTitle:nil otherButtonTitles:@"確定", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            if ([PFFacebookUtils isLinkedWithUser:user]) {
                _hud.labelText = NSLocalizedString(@"正在進行註冊", nil);
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", [user objectId]];
                //儲存用戶名稱
                [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:kPAPInstallationUserKey];
                [[PFInstallation currentInstallation] addUniqueObject:privateChannelName forKey:kPAPInstallationChannelsKey];
                [[PFInstallation currentInstallation] saveEventually];
                
                //儲存用戶名稱
                [userDefaults setValue:privateChannelName forKey:kPAPUserPrivateChannelKey];
                [userDefaults synchronize];
                [user setObject:privateChannelName forKey:kPAPUserPrivateChannelKey];
                
                //吃飯點數500點
                [user setObject:[NSNumber numberWithInt:500] forKey:@"myPoint"];
                
                PFACL *ACL = [PFACL ACL];
                [ACL setPublicReadAccess:YES];
                user.ACL = ACL;
                
                [user saveEventually:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        //轉場到 首頁 的畫面
                        // Request new Publish Permissions
                        if ([FBSDKAccessToken currentAccessToken]) {
                            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                if (!error) {
                                    NSLog(@"fetched user:%@", result);
                                    [self facebookRequestDidLoad:result];
                                }else{
                                    [self facebookRequestDidFailWithError:error];
                                }
                            }];
                        }
                    }else{
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"電話號碼已經被註册", nil) message:NSLocalizedString(@"此號碼已被註册", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
                    }
                }];
            }else{
                //沒有連結，錯誤
                NSLog(@"isLinkedWithUser = false");
            }
        } else {
            NSLog(@"User logged in through Facebook!");
            //舊的用戶，先確認手機是否已經經過驗證，經過驗證才能至首頁，否則就要到手機驗證畫面去
            
            if ([[user objectForKey:@"isPhoneVerified"] boolValue]) {
                //已經經過驗證
                [[AppDelegate sharedDelegate] presentToHomePage];
            }else{
                //尚未經過驗證
                [self performSegueWithIdentifier:@"addPhone" sender:facebookButton];
            }
        }
    }];
}

#pragma mark - Facebook Request Delegate
- (void)facebookRequestDidLoad:(id)result {
    // This method is called twice - once for the user's /me profile, and a second time when obtaining their friends. We will try and handle both scenarios in a single method.
    PFUser *user = [PFUser currentUser];
    
    NSArray *data = [result objectForKey:@"data"];
    
    if (data) {
        // we have friends data
        // 如果有朋友的資料
        NSMutableArray *facebookIds = [[NSMutableArray alloc] initWithCapacity:[data count]];
        for (NSDictionary *friendData in data) {
            if (friendData[@"id"]) {
                [facebookIds addObject:friendData[@"id"]];
            }
        }
        
        // cache friend data
        [[CMCache sharedCache] setFacebookFriends:facebookIds];
        
        if (user) {
            /* 暫時先不處理朋友資料，只要先存在本機就好
            */
        } else {
            /*登出*/
//            [(AppDelegate*)[[UIApplication sharedApplication] delegate] logOut];
        }
    } else {
        _hud.labelText = NSLocalizedString(@"正在創建用戶資料", nil);
        
        NSString *facebookId = [result objectForKey:@"id"];
        NSString *facebookName = [result objectForKey:@"name"];
        //新增用戶資料 名字、姓氏、性別、地區(用Graph API的代號)
        NSString *facebookFirst_Name = [result objectForKey:@"first_name"];
        NSString *facebookLast_Name = [result objectForKey:@"last_name"];
        NSString *facebookBirthday = [result objectForKey:@"birthday"];
        NSString *facebookEmail = [result objectForKey:@"email"];
        NSString *facebookGender = [result objectForKey:@"gender"];
        NSString *facebookLocation = [result objectForKey:@"locale"];
        
        if (user) {
            if (facebookName && [facebookName length] != 0) {
                [user setObject:facebookName forKey:kPAPUserDisplayNameKey];
            } else {
                [user setObject:[NSString stringWithFormat:@"%@%@", facebookFirst_Name, facebookLast_Name] forKey:kPAPUserDisplayNameKey];
            }
            if (facebookId && [facebookId length] != 0) {
                [user setObject:facebookId forKey:kPAPUserFacebookIDKey];
            }
            //儲存姓氏
            if (facebookFirst_Name && facebookFirst_Name != 0) {
                [[PFUser currentUser] setObject:facebookFirst_Name forKey:kPAPUserFacebookFirstNameKey];
            }
            //儲存名字
            if (facebookLast_Name && facebookLast_Name != 0) {
                [[PFUser currentUser] setObject:facebookLast_Name forKey:kPAPUserFacebookLastNameKey];
            }
            //儲存生日
            if (facebookBirthday && facebookBirthday != 0) {
                [[PFUser currentUser] setObject:facebookBirthday forKey:kPAPUserFacebookBirthdayKey];
            }
            //儲存email
            if (facebookEmail && facebookEmail != 0) {
                [[PFUser currentUser] setObject:facebookEmail forKey:kPAPUserFacebookEmailKey];
            }
            //儲存性別
            if (facebookGender && facebookGender != 0) {
                [[PFUser currentUser] setObject:facebookGender forKey:kPAPUserFacebookGenderKey];
            }
            //儲存地理位置
            if (facebookLocation && facebookLocation != 0) {
                [[PFUser currentUser] setObject:facebookLocation forKey:kPAPUserFacebookLocalsKey];
            }
            
            
            
            // Download user's profile picture
            NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [user objectForKey:kPAPUserFacebookIDKey]]];
            // Facebook profile picture cache policy: Expires in 2 weeks
            NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0.0f];
            [NSURLConnection connectionWithRequest:profilePictureURLRequest delegate:self];
            
            PFACL *ACL = [PFACL ACL];
            [ACL setPublicReadAccess:YES];
            [PFUser currentUser].ACL = ACL;
            
            [[PFUser currentUser] saveEventually:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [self performSegueWithIdentifier:@"addPhone" sender:facebookButton];
                }
            }];
        }
        
        /* 還不清楚要怎麼改成讀取朋友資料
        [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                [self facebookRequestDidLoad:result];
            } else {
                [self facebookRequestDidFailWithError:error];
            }
        }];
         */
    }
}

- (void)facebookRequestDidFailWithError:(NSError *)error {
    if ([PFUser currentUser]) {
        if ([[error userInfo][@"error"][@"type"] isEqualToString:@"OAuthException"]) {
            //登出
//            [(AppDelegate*)[[UIApplication sharedApplication] delegate] logOut];
        }
    }
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

@end
