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
#import "MenuDisclosureViewCell.h"
#import "FilterViewCell.h"

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
	
	self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // UITableView setup
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
	// Register cell nibs
	UINib *cellNib = [UINib nibWithNibName:@"PriceFilterViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"PriceFilterViewCell"];
	cellNib = [UINib nibWithNibName:@"PopularFilterViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"PopularFilterViewCell"];
	cellNib = [UINib nibWithNibName:@"SortFilterViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"SortFilterViewCell"];
	cellNib = [UINib nibWithNibName:@"MenuDisclosureViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"MenuDisclosureViewCell"];
	
	// UINavigationController setup
	self.navigationItem.title = @"Filters";
	UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(searchPressed)];
	self.navigationItem.rightBarButtonItem = searchButton;
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelPressed)];
	self.navigationItem.rightBarButtonItem = searchButton;
	self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
//	NSLog(@"FilterModel:%@", _filterModel);
}

- (void)viewWillDisappear:(BOOL)animated {
//	NSLog(@"FilterModel:%@", _filterModel);
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
			return sortExpanded ? 4 : 1;
		default:
			return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell <FilterViewCell> *cell;
	
	switch (indexPath.section) {
		
		// Price
		case 0:
			cell = [tableView dequeueReusableCellWithIdentifier:@"PriceFilterViewCell" forIndexPath:indexPath];
			[cell setFilterModel:_filterModel withValueName:@"price"];
			break;
		
		// Popular
		case 1:
			cell = [tableView dequeueReusableCellWithIdentifier:@"PopularFilterViewCell" forIndexPath:indexPath];
			((PopularFilterViewCell *)cell).titleLabel.text = popularTitles[indexPath.row];
			
			// Map model data to view.
			switch (indexPath.row) {
				case 0:
					[cell setFilterModel:_filterModel withValueName:@"openNow"];
					break;
				case 1:
					[cell setFilterModel:_filterModel withValueName:@"hotAndNew"];
					break;
				case 2:
					[cell setFilterModel:_filterModel withValueName:@"offeringADeal"];
					break;
				case 3:
					[cell setFilterModel:_filterModel withValueName:@"delivery"];
					break;
			}
			break;
			
		// Sort
		case 2:
			if (!sortExpanded) {
				cell = [tableView dequeueReusableCellWithIdentifier:@"MenuDisclosureViewCell" forIndexPath:indexPath];
				((MenuDisclosureViewCell *)cell).titleLabel.text = sortTitles[indexPath.row];
			} else {
				cell = [tableView dequeueReusableCellWithIdentifier:@"SortFilterViewCell" forIndexPath:indexPath];
				((SortFilterViewCell *)cell).titleLabel.text = sortTitles[indexPath.row];
				
				// Map model data to view.
				switch (indexPath.row) {
					case 0:
						[cell setFilterModel:_filterModel withValueName:@"bestMatch"];
						break;
					case 1:
						[cell setFilterModel:_filterModel withValueName:@"distance"];
						break;
					case 2:
						[cell setFilterModel:_filterModel withValueName:@"rating"];
						break;
					case 3:
						[cell setFilterModel:_filterModel withValueName:@"mostReviewed"];
						break;
				}
			}
			
			break;
					
		default:
			return nil;
	}
	
	return cell;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
		case 0:
			return 50;
		case 1:
			return 50;
		case 2:
			return 50;
		default:
			return 100;
	}
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 2) {
		sortExpanded = !sortExpanded;
		NSArray *indexPaths;
		[self.tableView beginUpdates];
		if (!sortExpanded) {
			// contract
			indexPaths = [NSArray arrayWithObjects:
						  [NSIndexPath indexPathForRow:1 inSection:indexPath.section],
						  [NSIndexPath indexPathForRow:2 inSection:indexPath.section],
						  [NSIndexPath indexPathForRow:3 inSection:indexPath.section],
						  nil];
			[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
		} else {
			// expand
			indexPaths = [NSArray arrayWithObjects:
						  [NSIndexPath indexPathForRow:1 inSection:indexPath.section],
						  [NSIndexPath indexPathForRow:2 inSection:indexPath.section],
						  [NSIndexPath indexPathForRow:3 inSection:indexPath.section],
						  nil];
			[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
		}
		[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
		[self.tableView endUpdates];
	}
}

- (void)cancelPressed {
	_filterModel.dirty = false;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)searchPressed {
	_filterModel.dirty = true;
	[self.navigationController popViewControllerAnimated:YES];
}

@end
