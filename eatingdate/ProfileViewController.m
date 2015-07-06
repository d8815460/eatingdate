//
//  ProfileViewController.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "ProfileViewController.h"
#import "MegaTheme.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bgImageView.image = [UIImage imageNamed: @"profile-bg"];
    profileImageView.image = [UIImage imageNamed:@"profile-pic-1"];
    profileImageView.layer.cornerRadius = 30;
    profileImageView.clipsToBounds = true;
    
    nameLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 20];
    nameLabel.textColor =  [UIColor whiteColor];
    nameLabel.text = @"John Hoylett";
    
    locationLabel.font = [UIFont fontWithName:MegaTheme.fontName size: 12];
    locationLabel.textColor =  [UIColor whiteColor];
    locationLabel.text = @"London, UK";
    
    locationImageView.image = [UIImage imageNamed:@"location"];
    
    CGFloat statsCountFontSize  = 16;
    CGFloat statsLabelFontSize  = 12;
    UIColor* statsCountColor =  [UIColor whiteColor];
    UIColor* statsLabelColor =  [UIColor colorWithWhite:0.7 alpha:1.0];
    
    followingCount.font = [UIFont fontWithName: MegaTheme.boldFontName size: statsCountFontSize];
    followingCount.textColor = statsCountColor;
    followingCount.text = @"35";
    
    followingLabel.font = [UIFont fontWithName: MegaTheme.fontName size: statsLabelFontSize];
    followingLabel.textColor = statsLabelColor;
    followingLabel.text = @"FOLLOWING";
    
    followersCount.font = [UIFont fontWithName: MegaTheme.boldFontName size: statsCountFontSize];
    followersCount.textColor = statsCountColor;
    followersCount.text = @"2200";
    
    followersLabel.font = [UIFont fontWithName: MegaTheme.fontName size: statsLabelFontSize];
    followersLabel.textColor = statsLabelColor;
    followersLabel.text = @"FOLLOWERS";
    
    photosCount.font = [UIFont fontWithName: MegaTheme.boldFontName size: statsCountFontSize];
    photosCount.textColor = statsCountColor;
    photosCount.text = @"45";
    
    photosLabel.font = [UIFont fontWithName: MegaTheme.fontName size: statsLabelFontSize];
    photosLabel.textColor = statsLabelColor;
    photosLabel.text = @"PHOTOS";
    
    checkinsLabel.font = [UIFont fontWithName: MegaTheme.lighterFontName size: 20];
    checkinsLabel.textColor = [UIColor blackColor];
    checkinsLabel.text = @"22 Check-ins";
    
    friendsLabel.font = [UIFont fontWithName: MegaTheme.lighterFontName size: 20];
    friendsLabel.textColor = [UIColor blackColor];
    friendsLabel.text = @"18 Common Friends";
    
    [self addBlurView];
    
    photosCollectionLabel.font = [UIFont fontWithName: MegaTheme.boldFontName size: 16];
    photosCollectionLabel.textColor = [UIColor blackColor];
    photosCollectionLabel.text = @"PHOTOS (31)";
    
    photosContainer.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    
    photosCollectionView.delegate = self;
    photosCollectionView.dataSource = self;
    photosCollectionView.backgroundColor = [UIColor clearColor];
    
    photosLayout.itemSize = CGSizeMake(90, 90);
    photosLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    photosLayout.minimumInteritemSpacing = 5;
    photosLayout.minimumLineSpacing = 10;
    photosLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    
    photos = @[@"photos-1", @"photos-2", @"photos-3", @"photos-4", @"photos-5", @"photos-6", @"photos-7", @"photos-8", @"photos-9"];
    
    friendsCollectionLabel.font = [UIFont fontWithName: MegaTheme.boldFontName size: 16];
    friendsCollectionLabel.textColor = [UIColor blackColor];
    friendsCollectionLabel.text = @"FRIENDS (22)";
    
    friendsCollectionView.delegate = self;
    friendsCollectionView.dataSource = self;
    friendsCollectionView.backgroundColor = [UIColor clearColor];
    
    friendsLayout.itemSize = CGSizeMake(45, 45);
    friendsLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    friendsLayout.minimumInteritemSpacing = 5;
    friendsLayout.minimumLineSpacing = 10;
    friendsLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    friends = @[@"friends-1", @"friends-2", @"friends-3", @"friends-4", @"friends-5",@"friends-6"];
    
    UIImage* doneImage = [[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    doneButton.tintColor = [UIColor whiteColor];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 250;
    }else if (indexPath.row == 3){
        return 400;
    }else if (indexPath.row == 4) {
        return 100;
    }else{
        return 44;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == photosCollectionView) {
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"Cell" forIndexPath: indexPath];
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
        NSString* photo = photos[indexPath.row];
        imageView.image = [UIImage imageNamed:photo];
        return cell;
        
    }else{
        
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath: indexPath];
        
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
        NSString* friend = friends[indexPath.row];
        imageView.image = [UIImage imageNamed:friend];
        imageView.layer.cornerRadius = 20;
        return cell;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == photosCollectionView) {
        return photos.count;
    }else{
        return friends.count;
    }
}

-(void) addBlurView
{
    
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView* blurView =  [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    blurView.frame = CGRectMake(0, 0, 600, 100);
    
    [blurView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [profileContainer insertSubview:blurView aboveSubview: bgImageView];
    
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:profileContainer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blurView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem: profileContainer attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: blurView attribute: NSLayoutAttributeBottom multiplier: 1.0 constant: 0.0];
    
    
    
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem: profileContainer attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual toItem: blurView attribute: NSLayoutAttributeLeft multiplier: 1.0 constant: 0.0];
    
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem: profileContainer attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual toItem: blurView attribute:NSLayoutAttributeRight multiplier: 1.0 constant: 0.0];
    
    [profileContainer addConstraints:@[topConstraint, rightConstraint, leftConstraint, bottomConstraint]];

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
    
}
-(void)doneTapped:(id)sender
{
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
