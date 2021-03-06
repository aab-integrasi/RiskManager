//
//  ISEventOffriskTableViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/9/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISEventOffriskTableViewController.h"
#import "IS6ColTableViewCell.h"

@interface ISEventOffriskTableViewController () {
	UIPopoverController *monthPickerPopover;
}

@end

@implementation ISEventOffriskTableViewController

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

	self.title = NSLocalizedStringWithDefaultValue(@"off risk reminder", nil, currentLanguageBundle, @"off risk reminder", nil);

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
	NSString *mthStr = [[df monthSymbols] objectAtIndex:dateComponents.month-1];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@ %ld", mthStr, (long)dateComponents.year] style:UIBarButtonItemStylePlain target:self action:@selector(changeMonth:)];

	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];

	_items = @[
			   @[@"2 Oct 2014",@"1000035720",@"HEQU",@"2 Nov 2014",@"IDR 50,000,000",@"full payment"],
			   @[@"8 Oct 2014",@"1000035734",@"HEQU",@"8 Nov 2014",@"IDR 10,000,000",@"installment 1"],
			   @[@"22 Oct 2014",@"1000035700",@"FIRE",@"22 Nov 2014",@"IDR 5,000,000",@"full payment"]
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

	_label1.font = [UIFont boldSystemFontOfSize:12.0f];
	_label2.font = [UIFont boldSystemFontOfSize:12.0f];
	_label3.font = [UIFont boldSystemFontOfSize:12.0f];
	_label4.font = [UIFont boldSystemFontOfSize:12.0f];
	_label5.font = [UIFont boldSystemFontOfSize:12.0f];
	_label6.font = [UIFont boldSystemFontOfSize:12.0f];

	_label1.translatesAutoresizingMaskIntoConstraints = NO;
	_label2.translatesAutoresizingMaskIntoConstraints = NO;
	_label3.translatesAutoresizingMaskIntoConstraints = NO;
	_label4.translatesAutoresizingMaskIntoConstraints = NO;
	_label5.translatesAutoresizingMaskIntoConstraints = NO;
	_label6.translatesAutoresizingMaskIntoConstraints = NO;

	_label1.text = NSLocalizedStringWithDefaultValue(@"Reminder Date", nil, currentLanguageBundle, @"Reminder Date", nil);
	_label2.text = NSLocalizedStringWithDefaultValue(@"Policy No", nil, currentLanguageBundle, @"Policy No", nil);
	_label3.text = NSLocalizedStringWithDefaultValue(@"Product", nil, currentLanguageBundle, @"Product", nil);
	_label4.text = NSLocalizedStringWithDefaultValue(@"Due Date", nil, currentLanguageBundle, @"Due Date", nil);
	_label5.text = NSLocalizedStringWithDefaultValue(@"Due Amount", nil, currentLanguageBundle, @"Due Amount", nil);
	_label6.text = NSLocalizedStringWithDefaultValue(@"Remarks", nil, currentLanguageBundle, @"Remarks", nil);

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

	_containerView.backgroundColor = [UIColor lightGrayColor];

	[_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:SIXCOLCONSTRAINT options:NSLayoutFormatAlignAllCenterY metrics:@{@"leftMargin": @15} views:NSDictionaryOfVariableBindings(_label1, _label2, _label3, _label4, _label5, _label6)]];
	[_containerView addConstraint:[NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];

	return _containerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    IS6ColTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
	if (!cell) {
		cell = [[IS6ColTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	NSArray *row = [_items objectAtIndex:indexPath.row];
	cell.label1.text = [row objectAtIndex:0];
	cell.label2.text = [row objectAtIndex:1];
	cell.label3.text = [row objectAtIndex:2];
	cell.label4.text = [row objectAtIndex:3];
	cell.label5.text = [row objectAtIndex:4];
	cell.label6.text = [row objectAtIndex:5];

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

#pragma mark - Date picker

- (void)changeMonth:(UIBarButtonItem *)sender {
	UIViewController *monthPickerViewController = [[UIViewController alloc] init];

	_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216.0f)];
	_picker.dataSource = self;
	_picker.delegate = self;

	monthPickerViewController.view = _picker;
	monthPickerViewController.preferredContentSize = _picker.bounds.size;

	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

	[_picker selectRow:dateComponents.month-1 inComponent:0 animated:YES];
	[_picker selectRow:dateComponents.year-2014 inComponent:1 animated:YES];

	monthPickerPopover = [[UIPopoverController alloc] initWithContentViewController:monthPickerViewController];
	[monthPickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == 0) {
		return 12;
	}
	else {
		return 4;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == 0) {
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		return [[df monthSymbols] objectAtIndex:row];
	}
	else {
		return [NSString stringWithFormat:@"%ld", (long)(2014 + row)];
	}
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
	self.title = NSLocalizedStringWithDefaultValue(@"off risk reminder", nil, currentLanguageBundle, @"off risk reminder", nil);

	[self.tableView reloadData];
}

@end
