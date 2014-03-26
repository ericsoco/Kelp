//
//  PriceFilterViewCell.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewCell.h"

@interface PriceFilterViewCell : UITableViewCell <FilterViewCell>

@property (weak, nonatomic) IBOutlet UISegmentedControl *valueControl;

@end
