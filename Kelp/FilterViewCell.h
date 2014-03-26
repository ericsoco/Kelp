//
//  FilterViewCell.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/25/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterModel.h"

@protocol FilterViewCell <NSObject>

@property (weak, nonatomic) FilterModel *filterModel;
@property (strong, nonatomic) NSString *filterValueName;

- (void)setFilterModel:(FilterModel *)model withValueName:(NSString *)name;

@end
