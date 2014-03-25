//
//  NumericFilterViewCell.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/24/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NumericFilterViewCell <NSObject>

@property (strong, nonatomic) NSNumber *modelValue;

@end
