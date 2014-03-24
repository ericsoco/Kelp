//
//  FilterTableViewController.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/23/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "FilterTableViewController.h"
#import "PriceFilterViewCell.h"
#import "PopularFilterViewCell.h"
#import "SortFilterViewCell.h"

@interface FilterTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FilterTableViewController

BOOL sortExpanded = NO;
NSArray *popularTitles;
NSArray *sortTitles;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		popularTitles = @[@"Open Now", @"Hot & New", @"Offering A Deal", @"Delivery"];
		sortTitles = @[@"Best Match", @"Distance", @"Rating", @"Most Reviewed"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // UITableView setup
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	UINib *cellNib = [UINib nibWithNibName:@"PriceFilterViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"PriceFilterViewCell"];
	cellNib = [UINib nibWithNibName:@"PopularFilterViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"PopularFilterViewCell"];
	cellNib = [UINib nibWithNibName:@"SortFilterViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"SortFilterViewCell"];
	
	// UINavigationController setup
//	self.navigationController.title = @"Filters";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return @"Price";
		case 1:
			return @"Most Popular";
		case 2:
			return @"Sort By";
		default:
			return nil;
	}
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//	
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 1;
		case 1:
			return 4;
		case 2:
			// TODO: if expanded...
			return 4;
		default:
			return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	switch (indexPath.section) {
		case 0:
			cell = [tableView dequeueReusableCellWithIdentifier:@"PriceFilterViewCell" forIndexPath:indexPath];
			break;
		case 1:
			cell = [tableView dequeueReusableCellWithIdentifier:@"PopularFilterViewCell" forIndexPath:indexPath];
			((PopularFilterViewCell *)cell).titleLabel.text = popularTitles[indexPath.row];
			break;
		case 2:
			cell = [tableView dequeueReusableCellWithIdentifier:@"SortFilterViewCell" forIndexPath:indexPath];
			((SortFilterViewCell *)cell).titleLabel.text = sortTitles[indexPath.row];
			break;
		default:
			return nil;
	}
	
	return cell;
}

@end
