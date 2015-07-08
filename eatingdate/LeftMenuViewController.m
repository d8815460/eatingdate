//
//  LeftMenuViewController.m
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/7/2.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MegaTheme.h"
@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && ![UIApplication sharedApplication].isStatusBarHidden)
    {
//        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        // The device is an iPhone or iPod touch.
        [self setFixedStatusBar];
    }
    
    if (![PFUser currentUser]) {
        self.profileImageView.image = [UIImage imageNamed:@"profile-pic-1"];
    }else{
        PFFile *profile = [[PFUser currentUser] objectForKey:kPAPUserProfilePicMediumKey];
        [profile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            self.profileImageView.image = [UIImage imageWithData:data];
        }];
    }
    self.profileImageView.layer.cornerRadius = 30;
    self.profileImageView.clipsToBounds = true;
    
    self.nameLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 20];
    self.nameLabel.textColor =  [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    self.postLabel.text = @"發佈約";
    self.dateLabel.text = @"吃飯行事曆";
    self.messagerLabel.text = @"訊息通知";
    self.heartLabel.text = @"口袋名單";
    self.historyLabel.text = @"歷史清單";
    self.gvipLabel.text = @"GVIP";
    self.tvipLabel.text = @"TVIP";
    self.pointLabel.text = @"點數查詢";
    self.settingLabel.text = @"設定";
    
    if (![PFUser currentUser]) {
        self.nameLabel.text = @"尚未登入";
    }else{
        self.nameLabel.text = [[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey];
    }
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6 or under
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        
    }
}

-(BOOL)prefersStatusBarHidden {
    return true;
}

- (void)setFixedStatusBar
{
    
    self.view = [[UIView alloc] initWithFrame:self.view.bounds];
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX(self.view.frame.size.width,self.view.frame.size.height), 20)];
    statusBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statusBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dateButtonPressed:(id)sender {
        [self performSegueWithIdentifier:@"firstRow" sender:self];
}

- (IBAction)messengerButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"secondRow" sender:self];
}

- (IBAction)heartButtonPressed:(id)sender {
}

- (IBAction)historyButtonPressed:(id)sender {
}

- (IBAction)gvipButtonPressed:(id)sender {
}

- (IBAction)tvipButtonPressed:(id)sender {
}

- (IBAction)pointButtonPressed:(id)sender {
}

- (IBAction)settingButtonPressed:(id)sender {
}

- (IBAction)feedbackButtonPressed:(id)sender {
}

- (IBAction)termOfServiceButtonPressed:(id)sender {
}
@end
