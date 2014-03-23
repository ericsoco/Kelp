//
//  BusinessListViewCell.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/20/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "BusinessListViewCell.h"
#import "BusinessModel.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@implementation BusinessListViewCell
{
	
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)initWithModel:(BusinessModel *)model {
	self.nameLabel.text = model.name;
	self.addressLabel.text = model.locationString;
	self.categoryLabel.text = model.categories;
	
	NSString *reviewsStr = [model.numReviews intValue] == 1 ? @"Review" : @"Reviews";
	self.numReviewsLabel.text = [NSString stringWithFormat:@"%@ %@", model.numReviews, reviewsStr];
	
	self.thumbImage.layer.cornerRadius = 6.0;
	self.thumbImage.layer.masksToBounds = YES;
	[self.thumbImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.imageURL]]
						   placeholderImage:nil//[UIImage imageNamed:@"placeholder-avatar"]
									success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
										self.thumbImage.image = image;
										/*
										self.thumbImage.alpha = 0.0;
										self.thumbImage.image = image;
										[UIView animateWithDuration:0.35 animations:^{
											self.thumbImage.alpha = 1.0;
										}];
										*/
									}
									failure:NULL];
	
	[self.ratingImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.ratingImageURL]]
						   placeholderImage:nil//[UIImage imageNamed:@"placeholder-avatar"]
									success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
										self.ratingImage.image = image;
										/*
										self.ratingImage.alpha = 0.0;
										self.ratingImage.image = image;
										[UIView animateWithDuration:0.35 animations:^{
											self.ratingImage.alpha = 1.0;
										}];
										*/
									}
									failure:NULL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
