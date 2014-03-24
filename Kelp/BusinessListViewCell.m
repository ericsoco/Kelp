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
	
	
	/*
	 // Manually size UILabels. Doesn't seem necessary.
	 CGRect newFrame = yourLabel.frame;
	 newFrame.size.height = calcSize.height;
	 yourLabel.frame = newFrame;
	 */
}

- (CGFloat)calcHeightWithModel:(BusinessModel *)model {
	
	double cellHeight = 0.0;
	CGSize minSize = CGSizeMake(320, 90);
	
	// -- sizeWithFont:... is deprecated, but I don't know how to specify leading (line spacing) without it.
	// Something about NSParagraphStyle...
	/*
	NSDictionary *nameLabelAttrs = @{
									 NSFontAttributeName: self.nameLabel.font
									 NSParagraphStyleAttributeName: self.nameLabel.
									 };
	CGSize calcSize = [model.name sizeWithAttributes:nameLabelAttrs];
	*/
	
	// -- This gives me the correct height of each UILabel, but I need to calculate the whitespace too...
	/*
	CGSize maxSize = CGSizeMake(211, 9999);
	cellHeight += [model.name sizeWithFont:self.nameLabel.font constrainedToSize:maxSize lineBreakMode:self.nameLabel.lineBreakMode].height;
	cellHeight += [model.locationString sizeWithFont:self.addressLabel.font constrainedToSize:maxSize lineBreakMode:self.addressLabel.lineBreakMode].height;
	cellHeight += [model.categories sizeWithFont:self.categoryLabel.font constrainedToSize:maxSize lineBreakMode:self.categoryLabel.lineBreakMode].height;
	*/
	
	// -- this returns 0.
	/*
	// Set all rendered content required to determine cell size...
	self.nameLabel.text = model.name;
	self.addressLabel.text = model.locationString;
	self.categoryLabel.text = model.categories;
	
	// ...and measure the result.
	cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
	*/
	
	
//	NSLog(@"calculated cell height:%f", cellHeight);
	cellHeight = MAX(minSize.height, cellHeight);
	
	return cellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
