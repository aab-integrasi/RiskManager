//
//  ISProfileTableViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/7/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISProfileTableViewController.h"
#import "ISProfileTableViewCell.h"

@interface ISProfileTableViewController ()

@end

@implementation ISProfileTableViewController

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

	self.navigationItem.title = NSLocalizedStringWithDefaultValue(@"my profile", nil, currentLanguageBundle, @"my profile", nil);

	_items = @[NSLocalizedStringWithDefaultValue(@"company name", nil, currentLanguageBundle, @"company name", nil),
			   NSLocalizedStringWithDefaultValue(@"address", nil, currentLanguageBundle, @"address", nil),
			   NSLocalizedStringWithDefaultValue(@"date of birth", nil, currentLanguageBundle, @"date of birth", nil),
			   NSLocalizedStringWithDefaultValue(@"line of business", nil, currentLanguageBundle, @"line of business", nil),
			   NSLocalizedStringWithDefaultValue(@"telephone", nil, currentLanguageBundle, @"telephone", nil),
			   NSLocalizedStringWithDefaultValue(@"websites", nil, currentLanguageBundle, @"websites", nil)];

	_profile = @[@"PT KKB Indonesia", @"Jl Gang Buntu No 18, Pejaten, Jakarta", @"10 Juy 2014", @"mining", @"62-21-7003579", @"www.kbi.co.id"];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ISProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
	if (!cell) {
		cell = [[ISProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	cell.label1.text = [_items objectAtIndex:indexPath.row];
	cell.label2.text = [_profile objectAtIndex:indexPath.row];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) languageUpdated {
	self.navigationItem.title = NSLocalizedStringWithDefaultValue(@"my profile", nil, currentLanguageBundle, @"my profile", nil);

	_items = @[NSLocalizedStringWithDefaultValue(@"company name", nil, currentLanguageBundle, @"company name", nil),
			   NSLocalizedStringWithDefaultValue(@"address", nil, currentLanguageBundle, @"address", nil),
			   NSLocalizedStringWithDefaultValue(@"date of birth", nil, currentLanguageBundle, @"date of birth", nil),
			   NSLocalizedStringWithDefaultValue(@"line of business", nil, currentLanguageBundle, @"line of business", nil),
			   NSLocalizedStringWithDefaultValue(@"telephone", nil, currentLanguageBundle, @"telephone", nil),
			   NSLocalizedStringWithDefaultValue(@"websites", nil, currentLanguageBundle, @"websites", nil)];

	[self.tableView reloadData];
}

@end
