//
//  FilterModel.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/24/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterModel

- (id)init {
	self.price = 0;
	self.openNow = NO;
	self.hotAndNew = NO;
	self.offeringADeal = NO;
	self.delivery = NO;
	self.bestMatch = NO;
	self.distance = NO;
	self.rating = NO;
	self.mostReviewed = NO;
	
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"Price:%i, Open:%i, Hot:%i, Deal:%i, Delivery:%i, Best:%i, Distance:%i, Rating:%i, Reviews:%i", [self.price intValue], [self.openNow intValue], [self.hotAndNew intValue], [self.offeringADeal intValue], [self.delivery intValue], [self.bestMatch intValue], [self.distance intValue], [self.rating intValue], [self.mostReviewed intValue]];
}

@end
