//
//  ISPremiumBudgetTableViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/10/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISPremiumBudgetTableViewController.h"
#import "IS4ColTableViewCell.h"
#import "ISMonthlyPremiumBudgetTableViewController.h"

@interface ISPremiumBudgetTableViewController () {
	UIPopoverController *monthPickerPopover;
}

@end

@implementation ISPremiumBudgetTableViewController

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

	self.title = NSLocalizedStringWithDefaultValue(@"premium budgeting", nil, currentLanguageBundle, @"premium budgeting", nil);

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
	NSString *mthStr = [[df monthSymbols] objectAtIndex:dateComponents.month-1];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@ %ld", mthStr, (long)dateComponents.year] style:UIBarButtonItemStylePlain target:self action:@selector(changeMonth:)];

	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];

	_items = @[
			   @[@"70,000,000\n(2 policy)", @"1,500\n(2 policy)", @""],
			   @[@"500,000,000\n(1 policy)", @"", @""],
			   @[@"500,000,000\n(1 policy)", @"", @""],
			   @[@"500,000,000\n(1 policy)", @"", @""]
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
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UILabel *_label1 = [[UILabel alloc] init];
	UILabel *_label2 = [[UILabel alloc] init];
	UILabel *_label3 = [[UILabel alloc] init];
	UILabel *_label4 = [[UILabel alloc] init];

	_label1.font = [UIFont boldSystemFontOfSize:12.0f];
	_label2.font = [UIFont boldSystemFontOfSize:12.0f];
	_label3.font = [UIFont boldSystemFontOfSize:12.0f];
	_label4.font = [UIFont boldSystemFontOfSize:12.0f];

	_label1.translatesAutoresizingMaskIntoConstraints = NO;
	_label2.translatesAutoresizingMaskIntoConstraints = NO;
	_label3.translatesAutoresizingMaskIntoConstraints = NO;
	_label4.translatesAutoresizingMaskIntoConstraints = NO;

	_label1.text = @"";
	_label2.text = NSLocalizedStringWithDefaultValue(@"IDR", nil, currentLanguageBundle, @"IDR", nil);
	_label3.text = NSLocalizedStringWithDefaultValue(@"USD", nil, currentLanguageBundle, @"USD", nil);
	_label4.text = NSLocalizedStringWithDefaultValue(@"EUR", nil, currentLanguageBundle, @"EUR", nil);

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

	_containerView.backgroundColor = [UIColor lightGrayColor];

	[_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:FOURCOLCONSTRAINT options:NSLayoutFormatAlignAllCenterY metrics:@{@"leftMargin": @15} views:NSDictionaryOfVariableBindings(_label1, _label2, _label3, _label4)]];
	[_containerView addConstraint:[NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];

	return _containerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    IS4ColTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
	if (!cell) {
		cell = [[IS4ColTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	cell.label1.text = [[df monthSymbols] objectAtIndex:indexPath.row];
	cell.label1.textAlignment = NSTextAlignmentRight;

	if (indexPath.row < [_items count]) {
		NSArray *row = [_items objectAtIndex:indexPath.row];
		cell.label2.text = [row objectAtIndex:0];
		cell.label3.text = [row objectAtIndex:1];
		cell.label4.text = [row objectAtIndex:2];

		cell.label2.numberOfLines = 0;
		cell.label3.numberOfLines = 0;
		cell.label4.numberOfLines = 0;
		cell.containerView.center = CGPointMake(cell.containerView.center.x, cell.center.y+10);

		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

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
	if (indexPath.row >= [_items count]) {
		return;
	}

	ISMonthlyPremiumBudgetTableViewController *detailView = [[ISMonthlyPremiumBudgetTableViewController alloc] init];
	detailView.selectedMonth = (int)indexPath.row;
	detailView.selectedYear = 2014;
	[self.navigationController pushViewController:detailView animated:YES];
}

/* // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Date picker

- (void)changeMonth:(UIBarButtonItem *)sender {
	UIViewController *monthPickerViewController = [[UIViewController alloc] init];

	_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216.0f)];
	_picker.dataSource = self;
	_picker.delegate = self;

	monthPickerViewController.view = _picker;
	monthPickerViewController.preferredContentSize = _picker.bounds.size;

	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

	[_picker selectRow:dateComponents.year-2014 inComponent:0 animated:YES];

	monthPickerPopover = [[UIPopoverController alloc] initWithContentViewController:monthPickerViewController];
	[monthPickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 4;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [NSString stringWithFormat:@"%ld", (long)(2014 + row)];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	/*if (component == 0) {
	 self.calendarView.month.month = row+1;
	 }
	 else {
	 self.calendarView.month.year = 2014+row;
	 }

	 NSDateFormatter *df = [[NSDateFormatter alloc] init];

	 NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

	 NSString *mthStr = [[df monthSymbols] objectAtIndex:dateComponents.month-1];
	 self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"%@ %ld", mthStr, (long)self.calendarView.month.year];*/
}

-(void) languageUpdated {
	self.title = NSLocalizedStringWithDefaultValue(@"premium budgeting", nil, currentLanguageBundle, @"premium budgeting", nil);

	[self.tableView reloadData];
}

@end
