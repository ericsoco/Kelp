//
//  FilterModel.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/24/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *openNow;
@property (strong, nonatomic) NSNumber *hotAndNew;
@property (strong, nonatomic) NSNumber *offeringADeal;
@property (strong, nonatomic) NSNumber *delivery;
@property (strong, nonatomic) NSNumber *bestMatch;
@property (strong, nonatomic) NSNumber *distance;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSNumber *mostReviewed;

@end
