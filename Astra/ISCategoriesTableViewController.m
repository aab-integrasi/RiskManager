//
//  ISCategoriesTableViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/1/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISCategoriesTableViewController.h"
#import "ISEventOffriskTableViewController.h"
#import "ISEventRenewalTableViewController.h"

@interface ISCategoriesTableViewController ()

@end

@implementation ISCategoriesTableViewController

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

	_items = @[NSLocalizedStringWithDefaultValue(@"off-risk", nil, currentLanguageBundle, @"off-risk", nil),
			   NSLocalizedStringWithDefaultValue(@"renewal", nil, currentLanguageBundle, @"renewal", nil),
			   NSLocalizedStringWithDefaultValue(@"claim documents collection", nil, currentLanguageBundle, @"claim documents collection", nil)];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageUpdated) name:@"updateLanguage" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
							 NSLocalizedStringWithDefaultValue(@"off-risk", nil, currentLanguageBundle, @"off-risk", nil): ^{
								 ISEventOffriskTableViewController *detailView = [[ISEventOffriskTableViewController alloc] init];
								 UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detailView];
								 NSArray *viewControllers = @[[self.splitViewController.viewControllers objectAtIndex:0], detailNav];
								 self.splitViewController.viewControllers = viewControllers;
							 },
							 NSLocalizedStringWithDefaultValue(@"renewal", nil, currentLanguageBundle, @"renewal", nil): ^{
								 ISEventRenewalTableViewController *detailView = [[ISEventRenewalTableViewController alloc] init];
								 UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detailView];
								 NSArray *viewControllers = @[[self.splitViewController.viewControllers objectAtIndex:0], detailNav];
								 self.splitViewController.viewControllers = viewControllers;
							 },
							 NSLocalizedStringWithDefaultValue(@"claim documents collection", nil, currentLanguageBundle, @"claim documents collection", nil): ^{

							 }
							 }[title];

	if (switchCase != nil) {
		switchCase();
	}

	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
	_items = @[NSLocalizedStringWithDefaultValue(@"off-risk", nil, currentLanguageBundle, @"off-risk", nil),
			   NSLocalizedStringWithDefaultValue(@"renewal", nil, currentLanguageBundle, @"renewal", nil),
			   NSLocalizedStringWithDefaultValue(@"claim documents collection", nil, currentLanguageBundle, @"claim documents collection", nil)];

	[self.tableView reloadData];
}

@end
