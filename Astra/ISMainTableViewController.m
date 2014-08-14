//
//  ISMainTableViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/1/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISMainTableViewController.h"
#import "ISLanguageTableViewController.h"
#import "ISCategoriesTableViewController.h"
#import "ISManagePolicyTableViewController.h"
#import "ISManageClaimTableViewController.h"
#import "ISRiskTipsTableViewController.h"
#import "ISHomeViewController.h"
#import "ISProfileTableViewController.h"
#import "ISPremiumBudgetTableViewController.h"
#import "FCActionSheet.h"

#import "ISURLConnection.h"

@interface ISMainTableViewController ()

@end

@implementation ISMainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PT KKB Indonesia" style:UIBarButtonItemStylePlain target:self action:@selector(changeCompany:)];

	UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
	[infoBtn addTarget:self action:@selector(infoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoBtn];
	//self.navigationItem.title = @"Mr. Mardiono";

	_items = @[NSLocalizedStringWithDefaultValue(@"home", nil, currentLanguageBundle, @"home", nil),
			   NSLocalizedStringWithDefaultValue(@"my profile", nil, currentLanguageBundle, @"my profile", nil),
			   NSLocalizedStringWithDefaultValue(@"event by category", nil, currentLanguageBundle, @"event by category", nil),
			   NSLocalizedStringWithDefaultValue(@"manage your policy", nil, currentLanguageBundle, @"manage your policy", nil),
			   NSLocalizedStringWithDefaultValue(@"premium budgeting", nil, currentLanguageBundle, @"premium budgeting", nil),
			   NSLocalizedStringWithDefaultValue(@"manage your claim", nil, currentLanguageBundle, @"manage your claim", nil),
			   NSLocalizedStringWithDefaultValue(@"quick claim", nil, currentLanguageBundle, @"quick claim", nil),
			   NSLocalizedStringWithDefaultValue(@"claim monitoring", nil, currentLanguageBundle, @"claim monitoring", nil),
			   NSLocalizedStringWithDefaultValue(@"risk management tips", nil, currentLanguageBundle, @"risk management tips", nil)];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageUpdated) name:@"updateLanguage" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeCompany:(UIBarButtonItem *)sender {
	FCActionSheet *actionSheet = [[FCActionSheet alloc] initWithTitle:nil];

	[actionSheet addButtonWithTitle:@"PT KKB Indonesia" action:^{
		sender.title = @"PT KKB Indonesia";
	}];
	[actionSheet addButtonWithTitle:@"PT ABC Indonesia" action:^{
		sender.title = @"PT ABC Indonesia";
	}];
	[actionSheet addButtonWithTitle:@"PT Cemerlang" action:^{
		sender.title = @"PT Cemerlang";
	}];

	[actionSheet addCancelButtonWithAction:nil];

	[actionSheet showFromBarButtonItem:sender animated:YES];
}

- (void)infoButtonAction:(UIButton *)sender {
	FCActionSheet *infoSheet = [[FCActionSheet alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Welcome, %@", nil, currentLanguageBundle, @"Welcome, %@", nil), @"Mr. Mardiono"]];

	[infoSheet addButtonWithTitle:NSLocalizedStringWithDefaultValue(@"about us", nil, currentLanguageBundle, @"about us", nil)];
	[infoSheet addButtonWithTitle:NSLocalizedStringWithDefaultValue(@"log out", nil, currentLanguageBundle, @"log out", nil)];
	[infoSheet addButtonWithTitle:NSLocalizedStringWithDefaultValue(@"language / bahasa", nil, currentLanguageBundle, @"language / bahasa", nil) action:^{
		NSLog(@"tap");
		[self performSelector:@selector(presentLanguageSelector) withObject:nil afterDelay:0.1f];
	}];
	[infoSheet addCancelButtonWithAction:nil];

	[infoSheet showFromBarButtonItem:self.navigationItem.leftBarButtonItem animated:YES];
}

- (void)presentLanguageSelector {
	ISLanguageTableViewController *langVC = [[ISLanguageTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:langVC];
	nav.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
	if (_items) {
		return 1;
	}

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	NSString *title = [_items objectAtIndex:indexPath.row];

	if ([title isEqualToString:NSLocalizedStringWithDefaultValue(@"event by category", nil, currentLanguageBundle, @"event by category", nil)]
		|| [title isEqualToString:NSLocalizedStringWithDefaultValue(@"manage your policy", nil, currentLanguageBundle, @"manage your policy", nil)]
		|| [title isEqualToString:NSLocalizedStringWithDefaultValue(@"manage your claim", nil, currentLanguageBundle, @"manage your claim", nil)]
		|| [title isEqualToString:NSLocalizedStringWithDefaultValue(@"risk management tips", nil, currentLanguageBundle, @"risk management tips", nil)]) {
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	cell.textLabel.text = title;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *title = [_items objectAtIndex:indexPath.row];

	void (^switchCase)() = @{
							 NSLocalizedStringWithDefaultValue(@"home", nil, currentLanguageBundle, @"home", nil): ^{
								 ISHomeViewController *detailView = [[ISHomeViewController alloc] init];
								 UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detailView];
								 NSArray *viewControllers = @[[self.splitViewController.viewControllers objectAtIndex:0], detailNav];
								 self.splitViewController.viewControllers = viewControllers;
							 },
							 NSLocalizedStringWithDefaultValue(@"my profile", nil, currentLanguageBundle, @"my profile", nil): ^{
								 ISProfileTableViewController *profileView = [[ISProfileTableViewController alloc] init];
								 UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:profileView];
								 NSArray *viewControllers = @[[self.splitViewController.viewControllers objectAtIndex:0], nav];
								 self.splitViewController.viewControllers = viewControllers;
							 },
							 NSLocalizedStringWithDefaultValue(@"event by category", nil, currentLanguageBundle, @"event by category", nil): ^{
								 ISCategoriesTableViewController *categoriesView = [[ISCategoriesTableViewController alloc] init];
								 [self.navigationController pushViewController:categoriesView animated:YES];
							 },
							 NSLocalizedStringWithDefaultValue(@"manage your policy", nil, currentLanguageBundle, @"manage your policy", nil): ^{
								 ISManagePolicyTableViewController *detailView = [[ISManagePolicyTableViewController alloc] init];
								 [self.navigationController pushViewController:detailView animated:YES];
							 },
							 NSLocalizedStringWithDefaultValue(@"manage your claim", nil, currentLanguageBundle, @"manage your claim", nil): ^{
								 ISManageClaimTableViewController *detailView = [[ISManageClaimTableViewController alloc] init];
								 [self.navigationController pushViewController:detailView animated:YES];
							 },
							 NSLocalizedStringWithDefaultValue(@"risk management tips", nil, currentLanguageBundle, @"risk management tips", nil): ^{
								 ISRiskTipsTableViewController *detailView = [[ISRiskTipsTableViewController alloc] init];
								 [self.navigationController pushViewController:detailView animated:YES];
							 },
							 NSLocalizedStringWithDefaultValue(@"premium budgeting", nil, currentLanguageBundle, @"premium budgeting", nil): ^{
								 ISPremiumBudgetTableViewController *detailView = [[ISPremiumBudgetTableViewController alloc] init];
								 UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detailView];
								 NSArray *viewControllers = @[[self.splitViewController.viewControllers objectAtIndex:0], detailNav];
								 self.splitViewController.viewControllers = viewControllers;
							 }
							 }[title];

	if (switchCase != nil) {
		switchCase();
	}
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) languageUpdated {
	_items = @[NSLocalizedStringWithDefaultValue(@"home", nil, currentLanguageBundle, @"home", nil),
			   NSLocalizedStringWithDefaultValue(@"my profile", nil, currentLanguageBundle, @"my profile", nil),
			   NSLocalizedStringWithDefaultValue(@"event by category", nil, currentLanguageBundle, @"event by category", nil),
			   NSLocalizedStringWithDefaultValue(@"manage your policy", nil, currentLanguageBundle, @"manage your policy", nil),
			   NSLocalizedStringWithDefaultValue(@"premium budgeting", nil, currentLanguageBundle, @"premium budgeting", nil),
			   NSLocalizedStringWithDefaultValue(@"manage your claim", nil, currentLanguageBundle, @"manage your claim", nil),
			   NSLocalizedStringWithDefaultValue(@"quick claim", nil, currentLanguageBundle, @"quick claim", nil),
			   NSLocalizedStringWithDefaultValue(@"claim monitoring", nil, currentLanguageBundle, @"claim monitoring", nil),
			   NSLocalizedStringWithDefaultValue(@"risk management tips", nil, currentLanguageBundle, @"risk management tips", nil)];

	[self.tableView reloadData];
	[self.navigationController.view setNeedsDisplay];
}

@end
