//
//  FilterTableViewController.h
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"
#import "SortFilterViewCell.h"

@interface FilterTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate/*, SortCellDelegate*/>

@property (strong, nonatomic) FilterModel *filterModel;

@end
