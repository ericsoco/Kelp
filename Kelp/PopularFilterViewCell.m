//
//  PopularFilterViewCell.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "PopularFilterViewCell.h"

@implementation PopularFilterViewCell

@synthesize modelValue = _modelValue;

- (void)awakeFromNib
{
    // Initialization code
	[self.valueSwitch addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelValue:(NSNumber *)value {
	self.valueSwitch.on = !!value;
}

- (void)didChangeValue:(id)sender {
	_modelValue = [NSNumber numberWithBool:self.valueSwitch.isOn];
}

@end
