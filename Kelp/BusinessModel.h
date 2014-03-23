//
//  BusinessModel.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/20/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <MapKit/MapKit.h>

@interface BusinessModel : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *neighborhood;
@property (strong, nonatomic) NSString *locationString;
@property (strong, nonatomic) NSString *categories;
@property (strong, nonatomic) NSNumber *numReviews;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSString *ratingImageURL;

//@property (assign, nonatomic) CLLocationCoordinate2D location;

+ (BusinessModel *)initWithJSON:(NSDictionary *)json;

@end
