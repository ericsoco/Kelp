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

@interface BusinessListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BusinessListViewController
{
	YelpClient *yelpClient;
	NSMutableArray *currentBusinessModels;
}

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
	UINib *cellNib = [UINib nibWithNibName:@"BusinessListViewCell" bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:@"BusinessListViewCell"];
	
	// UINavigationBar setup
	[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.812 green:0.094 blue:0.024 alpha:1.0]];
	[self.navigationController.navigationBar setTranslucent:YES];
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
	
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterPressed)];
	[leftButton setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
	self.navigationItem.leftBarButtonItem = leftButton;
	
	// UISearchBar setup
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(54, 6, 212, 32)];
	searchBar.showsCancelButton = NO;
	[self.navigationController.navigationBar addSubview:searchBar];
	searchBar.delegate = self;
//	searchBar.placeholder = @"Search for local businesses";
	
	// Init Yelp service layer
	yelpClient = [[YelpClient alloc] initWithConsumerKey:YELP_CONSUMER_KEY consumerSecret:YELP_CONSUMER_SECRET accessToken:YELP_TOKEN accessSecret:YELP_TOKEN_SECRET];
	
	[self executeSearchWithQuery:@"japanese"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
	return 90;
}

#pragma mark - UI and UISearchBarDelegate protocol implementation
- (void)filterPressed {
	NSLog(@"filter button pressed");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self executeSearchWithQuery:searchBar.text];
	[searchBar resignFirstResponder];
}

- (void)executeSearchWithQuery:(NSString *)query {
	// TODO: check filters
	
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
