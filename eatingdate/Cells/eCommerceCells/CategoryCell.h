//
//  CategoryCell.h
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UICollectionViewCell
{
    CGRect blurViewFrame;
}

@property(nonatomic, strong) IBOutlet UIImageView* imageView;

@property(nonatomic, strong) IBOutlet UILabel* titleLabel;

@property(nonatomic, strong) IBOutlet UILabel* countLabel;

@property(nonatomic, strong) IBOutlet UIView* alphaView;

@end
