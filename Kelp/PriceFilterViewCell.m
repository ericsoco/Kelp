//
//  PriceFilterViewCell.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "PriceFilterViewCell.h"

@implementation PriceFilterViewCell

@synthesize modelValue = _modelValue;

- (void)awakeFromNib
{
    // Initialization code
	[self.valueControl addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelValue:(NSNumber *)value {
	self.valueControl.selectedSegmentIndex = [value integerValue];
}

- (void)didChangeValue:(id)sender {
	_modelValue = [NSNumber numberWithInteger:self.valueControl.selectedSegmentIndex];
	NSLog(@"set model value to:%i", [_modelValue intValue]);
}

@end
