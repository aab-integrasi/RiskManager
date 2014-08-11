//
//  ISManageClaimDetailTableViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/10/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISManageClaimDetailTableViewController.h"
#import "IS7ColTableViewCell.h"

@interface ISManageClaimDetailTableViewController ()

@end

@implementation ISManageClaimDetailTableViewController

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

	self.title = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"%@ claim detail", nil, currentLanguageBundle, @"%@ claim detail", nil), _claimID];

	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];

	_items = @[
			   @[@"70001111",@"free",@"10 May 2014",@"comprehensive",@"-",@"accident",@"kendal"]
			   ];

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UILabel *_label1 = [[UILabel alloc] init];
	UILabel *_label2 = [[UILabel alloc] init];
	UILabel *_label3 = [[UILabel alloc] init];
	UILabel *_label4 = [[UILabel alloc] init];
	UILabel *_label5 = [[UILabel alloc] init];
	UILabel *_label6 = [[UILabel alloc] init];
	UILabel *_label7 = [[UILabel alloc] init];

	_label1.font = [UIFont boldSystemFontOfSize:12.0f];
	_label2.font = [UIFont boldSystemFontOfSize:12.0f];
	_label3.font = [UIFont boldSystemFontOfSize:12.0f];
	_label4.font = [UIFont boldSystemFontOfSize:12.0f];
	_label5.font = [UIFont boldSystemFontOfSize:12.0f];
	_label6.font = [UIFont boldSystemFontOfSize:12.0f];
	_label7.font = [UIFont boldSystemFontOfSize:12.0f];

	_label1.translatesAutoresizingMaskIntoConstraints = NO;
	_label2.translatesAutoresizingMaskIntoConstraints = NO;
	_label3.translatesAutoresizingMaskIntoConstraints = NO;
	_label4.translatesAutoresizingMaskIntoConstraints = NO;
	_label5.translatesAutoresizingMaskIntoConstraints = NO;
	_label6.translatesAutoresizingMaskIntoConstraints = NO;
	_label7.translatesAutoresizingMaskIntoConstraints = NO;

	_label1.text = NSLocalizedStringWithDefaultValue(@"Claim no", nil, currentLanguageBundle, @"Claim no", nil);
	_label2.text = NSLocalizedStringWithDefaultValue(@"Product", nil, currentLanguageBundle, @"Product", nil);
	_label3.text = NSLocalizedStringWithDefaultValue(@"Date of loss", nil, currentLanguageBundle, @"Date of loss", nil);
	_label4.text = NSLocalizedStringWithDefaultValue(@"Object", nil, currentLanguageBundle, @"Object", nil);
	_label5.text = NSLocalizedStringWithDefaultValue(@"Vessel", nil, currentLanguageBundle, @"Vessel", nil);
	_label6.text = NSLocalizedStringWithDefaultValue(@"Cause of loss", nil, currentLanguageBundle, @"Cause of loss", nil);
	_label7.text = NSLocalizedStringWithDefaultValue(@"Location of loss", nil, currentLanguageBundle, @"Location of loss", nil);

	/*label1.textAlignment = NSTextAlignmentCenter;
	 label2.textAlignment = NSTextAlignmentCenter;
	 label3.textAlignment = NSTextAlignmentCenter;
	 label4.textAlignment = NSTextAlignmentCenter;
	 label5.textAlignment = NSTextAlignmentCenter;
	 label6.textAlignment = NSTextAlignmentCenter;*/

	UIView *_containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
	[_containerView addSubview:_label1];
	[_containerView addSubview:_label2];
	[_containerView addSubview:_label3];
	[_containerView addSubview:_label4];
	[_containerView addSubview:_label5];
	[_containerView addSubview:_label6];
	[_containerView addSubview:_label7];

	_containerView.backgroundColor = [UIColor lightGrayColor];

	[_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:SEVENCOLCONSTRAINT options:NSLayoutFormatAlignAllCenterY metrics:@{@"leftMargin": @15} views:NSDictionaryOfVariableBindings(_label1, _label2, _label3, _label4, _label5, _label6, _label7)]];
	[_containerView addConstraint:[NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];

	return _containerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    IS7ColTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
	if (!cell) {
		cell = [[IS7ColTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	NSArray *row = [_items objectAtIndex:indexPath.row];
	cell.label1.text = [row objectAtIndex:0];
	cell.label2.text = [row objectAtIndex:1];
	cell.label3.text = [row objectAtIndex:2];
	cell.label4.text = [row objectAtIndex:3];
	cell.label5.text = [row objectAtIndex:4];
	cell.label6.text = [row objectAtIndex:5];
	cell.label7.text = [row objectAtIndex:6];

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
	self.title = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"%@ claim detail", nil, currentLanguageBundle, @"%@ claim detail", nil), _claimID];

	[self.tableView reloadData];
}

@end
