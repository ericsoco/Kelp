//
//  BusinessModel.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/20/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "BusinessModel.h"


@interface BusinessModel ()

@end

@implementation BusinessModel

+ (NSMutableDictionary *)models {
	// Static variables are declared only once. Ever.
	static NSMutableDictionary *modelsDict = nil;
	
	// Initialize only once.
	if (!modelsDict) {
		modelsDict = [NSMutableDictionary dictionary];
	}
	
	return modelsDict;
}

+ (BusinessModel *)initWithJSON:(NSDictionary *)json {
	BusinessModel *model = [BusinessModel models][json[@"id"]];
	if (!model) {
		model = [[BusinessModel alloc] init];
		model.id = json[@"id"];
		model.imageURL = json[@"image_url"];
		model.name = json[@"name"];
		model.address = json[@"location"][@"address"][0];
		model.neighborhood = json[@"location"][@"neighborhoods"][0];
		model.locationString = [NSString stringWithFormat:@"%@, %@", model.address, model.neighborhood];
		
		NSMutableArray *categoryNames = [NSMutableArray array];
		[(NSArray *)json[@"categories"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[categoryNames addObject:((NSArray *)obj)[0]];
		}];
		model.categories = [categoryNames componentsJoinedByString:@", "];
		
		model.numReviews = json[@"review_count"];
		model.rating = json[@"rating"];
		model.ratingImageURL = json[@"rating_img_url"];
		
		[BusinessModel models][json[@"id"]] = model;
	}
	
	return model;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<BusinessModel: %@>", self.name];
}

@end
