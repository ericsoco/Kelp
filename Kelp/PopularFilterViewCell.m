//
//  PopularFilterViewCell.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "PopularFilterViewCell.h"

@implementation PopularFilterViewCell

@synthesize filterModel = _filterModel;
@synthesize filterValueName = _filterValueName;

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

- (void)setFilterModel:(FilterModel *)model withValueName:(NSString *)name {
	self.filterModel = model;
	self.filterValueName = name;
	self.valueSwitch.on = [[self.filterModel valueForKey:self.filterValueName] boolValue];
}

- (void)didChangeValue:(id)sender {
	[self.filterModel setValue:[NSNumber numberWithBool:self.valueSwitch.isOn] forKey:self.filterValueName];
}

@end
