//
//  PhotoCell.h
//  Mega
//
//  Created by Sergey on 2/4/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

@property(nonatomic, strong) IBOutlet UIImageView* coverImageView;
@property(nonatomic, strong) IBOutlet UIImageView* iconImageView;
@property(nonatomic, strong) IBOutlet UILabel* countLabel;

@end
