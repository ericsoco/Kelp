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
	self.openNow = 0;
	self.hotAndNew = 0;
	self.offeringADeal = 0;
	self.delivery = 0;
	self.bestMatch = 0;
	self.distance = 0;
	self.rating = 0;
	self.mostReviewed = 0;
	
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"Price:%i, Open:%i, Hot:%i, Deal:%i, Delivery:%i, Best:%i, Distance:%i, Rating:%i, Reviews:%i", [self.price intValue], [self.openNow intValue], [self.hotAndNew intValue], [self.offeringADeal intValue], [self.delivery intValue], [self.bestMatch intValue], [self.distance intValue], [self.rating intValue], [self.mostReviewed intValue]];
}

@end
