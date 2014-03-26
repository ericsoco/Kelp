//
//  PriceFilterViewCell.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "PriceFilterViewCell.h"

@implementation PriceFilterViewCell

@synthesize filterModel = _filterModel;
@synthesize filterValueName = _filterValueName;

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

- (void)setFilterModel:(FilterModel *)model withValueName:(NSString *)name {
	self.filterModel = model;
	self.filterValueName = name;
	self.valueControl.selectedSegmentIndex = [[self.filterModel valueForKey:self.filterValueName] intValue];
}

- (void)didChangeValue:(id)sender {
	[self.filterModel setValue:[NSNumber numberWithInt:self.valueControl.selectedSegmentIndex] forKey:self.filterValueName];
}

@end
