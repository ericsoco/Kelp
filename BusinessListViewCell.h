//
//  BusinessListViewCell.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/20/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessModel.h"

@interface BusinessListViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *numReviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

- (void)initWithModel:(BusinessModel *)model;

@end
