//
//  BusinessListViewController.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/20/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "BusinessListViewController.h"
#import "BusinessListViewCell.h"
#import "BusinessModel.h"
#import "YelpClient.h"
#import "Constants.h"
#import "ZAActivityBar.h"
#import "FilterTableViewController.h"
#import "FilterModel.h"

@interface BusinessListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BusinessListViewController

YelpClient *yelpClient;
NSMutableArray *currentBusinessModels;
UISearchBar *searchBar;
UITapGestureRecognizer *searchDismissGestureRecognizer;
BusinessListViewCell *_cellForMetrics;
FilterTableViewController *_filterTableViewController;
FilterModel *_filterModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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
	UINib *cellNib = [UINib nibWithNibName:@"BusinessListViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"BusinessListViewCell"];
	
	// UINavigationBar setup
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterPressed)];
	[leftButton setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
	self.navigationItem.leftBarButtonItem = leftButton;
	
	// UISearchBar setup
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(54, 6, 212, 32)];
	searchBar.showsCancelButton = NO;
	searchBar.delegate = self;
	
	// Init Yelp service layer
	yelpClient = [[YelpClient alloc] initWithConsumerKey:YELP_CONSUMER_KEY consumerSecret:YELP_CONSUMER_SECRET accessToken:YELP_TOKEN accessSecret:YELP_TOKEN_SECRET];
	
	// Create and initialize a tap gesture
	searchDismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
	searchDismissGestureRecognizer.numberOfTapsRequired = 1;
	
	_filterTableViewController = [[FilterTableViewController alloc] init];
	_filterModel = [[FilterModel alloc] init];
	_filterTableViewController.filterModel = _filterModel;
	
	[self executeSearchWithQuery:@"japanese"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController.navigationBar addSubview:searchBar];
}

- (void)viewWillDisappear:(BOOL)animated {
	[searchBar removeFromSuperview];
}

#pragma mark - UITableView protocol implementation
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return currentBusinessModels ? [currentBusinessModels count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	BusinessListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessListViewCell" forIndexPath:indexPath];
	if (!currentBusinessModels || [currentBusinessModels count] == 0) { return cell; }
	
	[cell initWithModel:[currentBusinessModels objectAtIndex:[indexPath row]]];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (!currentBusinessModels || [currentBusinessModels count] == 0) { return 90; }
	return [[self cellForMetrics] calcHeightWithModel:currentBusinessModels[[indexPath row]]];
}

/**
 * Generate a cell to populate with data and measure.
 */
- (BusinessListViewCell *) cellForMetrics {
	if (!_cellForMetrics) {
		_cellForMetrics = [self.tableView dequeueReusableCellWithIdentifier:@"BusinessListViewCell"];
	}
	return _cellForMetrics;
}

#pragma mark - UI and UISearchBarDelegate protocol implementation
- (void)filterPressed {
	[self.navigationController pushViewController:_filterTableViewController animated:YES];
}

- (void)onTapped:(UITapGestureRecognizer *)gesture {
	// Dismiss search bar keyboard if open.
	[searchBar resignFirstResponder];
	[self.tableView removeGestureRecognizer:searchDismissGestureRecognizer];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	// Add tap recognizer on view to dismiss keyboard
	[self.tableView addGestureRecognizer:searchDismissGestureRecognizer];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)bar {
	[self executeSearchWithQuery:searchBar.text];
	[searchBar resignFirstResponder];
	
	// Remove tap recognizer on view to dismiss keyboard
	[self.tableView removeGestureRecognizer:searchDismissGestureRecognizer];
}

- (void)executeSearchWithQuery:(NSString *)query {
//	NSLog(@"TODO: Apply FilterModel to query:%@", _filterModel);
	
//	[ZAActivityBar showWithStatus:@"Searching local businesses..."];
	
	// Recreate currentBusinessModels
	currentBusinessModels = [NSMutableArray array];
	
	[yelpClient searchWithTerm:query success:^(AFHTTPRequestOperation *operation, id response) {
		
		if ([response isKindOfClass:[NSDictionary class]]) {
			for (NSDictionary *businessData in response[@"businesses"]) {
				[currentBusinessModels addObject:[BusinessModel initWithJSON:businessData]];
			}
			[self.tableView reloadData];
			[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//			[ZAActivityBar showSuccessWithStatus:@"Movies loaded."];
		} else {
//			[ZAActivityBar showErrorWithStatus:@"Something went wrong. Please pull down to reload movies."];
//			[ZAActivityBar showErrorWithStatus:@"‼️ Something went wrong..."];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"‼️ Search request failed with error:%@", error);
//		[ZAActivityBar showErrorWithStatus:@"‼️ Something went wrong..."];
	}];
}

@end
