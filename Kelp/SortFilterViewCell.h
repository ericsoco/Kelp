//
//  SortFilterViewCell.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewCell.h"

@interface SortFilterViewCell : UITableViewCell <FilterViewCell>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;

@end
