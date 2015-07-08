//
//  ProductCell.h
//  Mega
//
//  Created by Sergey on 1/30/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell

@property(nonatomic, strong) IBOutlet UIImageView* imageView;

@property(nonatomic, strong) IBOutlet UILabel* titleLabel;

@property(nonatomic, strong) IBOutlet UILabel* priceLabel;

@property(nonatomic, strong) IBOutlet UIView* blurView ;

@property(nonatomic) CGRect blurViewFrame ;

-(void)setCellSelected:(BOOL)selected;

@end
