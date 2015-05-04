//
//  ProfileViewController.h
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuLeftTableViewController.h"

@interface ProfileViewController : AMSlideMenuLeftTableViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UIImageView* bgImageView;
    IBOutlet UIImageView* profileImageView;
    
    IBOutlet UIView* profileContainer;
    IBOutlet UIButton* doneButton;
    
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* locationLabel;
    IBOutlet UIImageView* locationImageView;
    
    IBOutlet UILabel* followersLabel;
    IBOutlet UILabel* followersCount;
    IBOutlet UILabel* followingLabel;
    IBOutlet UILabel* followingCount;
    IBOutlet UILabel* photosLabel;
    IBOutlet UILabel* photosCount;
    
    IBOutlet UILabel* checkinsLabel;
    IBOutlet UILabel* friendsLabel;
    
    IBOutlet UIView* photosContainer;
    IBOutlet UILabel* photosCollectionLabel;
    IBOutlet UICollectionView* photosCollectionView;
    IBOutlet UICollectionViewFlowLayout* photosLayout;
    
    NSArray* photos;
    
    IBOutlet UILabel* friendsCollectionLabel;
    IBOutlet UICollectionView* friendsCollectionView;
    IBOutlet UICollectionViewFlowLayout* friendsLayout;
    
    NSArray* friends;
    
}

-(IBAction)doneTapped:(id)sender;
@end
