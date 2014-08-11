//
//  ISHomeViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/1/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISHomeViewController.h"
#import "ISCalendarCell.h"
#import "ALActionBlocks.h"

@interface ISHomeViewController () {
	UIPopoverController *monthPickerPopover;
}

@end

@implementation ISHomeViewController

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
    [[self.navigationController navigationBar] setTranslucent:NO];

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	NSString *mthStr = [[df monthSymbols] objectAtIndex:self.calendarView.month.month-1];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@ %ld", mthStr, (long)self.calendarView.month.year] style:UIBarButtonItemStylePlain target:self action:@selector(changeMonth:)];

	self.calendarView.currentDayColor = [UIColor colorWithRed:0.0f green:122.0/255.0f blue:1.0f alpha:0.5f];
	[self.calendarView setSeparatorStyle:RDVCalendarViewDayCellSeparatorTypeBoth];
	[self.calendarView registerDayCellClass:[ISCalendarCell class]];

	/*[self.calendarView showCurrentMonth];
	[self.calendarView showNextMonth];
	[self.calendarView showPreviousMonth];*/
}

- (void)changeMonth:(UIBarButtonItem *)sender {
	UIViewController *monthPickerViewController = [[UIViewController alloc] init];

	_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216.0f)];
	_picker.dataSource = self;
	_picker.delegate = self;

	monthPickerViewController.view = _picker;
	monthPickerViewController.preferredContentSize = _picker.bounds.size;

	[_picker selectRow:self.calendarView.month.month-1 inComponent:0 animated:YES];
	[_picker selectRow:self.calendarView.month.year-2014 inComponent:1 animated:YES];

	monthPickerPopover = [[UIPopoverController alloc] initWithContentViewController:monthPickerViewController];
	[monthPickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RDVCalendarViewDelegate

- (void)calendarView:(RDVCalendarView *)calendarView configureDayCell:(RDVCalendarDayCell *)dayCell atIndex:(NSInteger)index {
	ISCalendarCell *cell = (ISCalendarCell *)dayCell;

	NSDate *date = [self.calendarView dateForIndex:index];
	NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
	if ([comps weekday] == 1) {
		cell.textLabel.textColor = [UIColor redColor];
	}

	if (index%3 == 0) {
		cell.offRisk.hidden = NO;
		[cell.offRisk handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
			if (nil == self.roundRectButtonPopTipView) {
				self.roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage:[NSString stringWithFormat:@"Off risk at: %@", date]];
				self.roundRectButtonPopTipView.delegate = self;
				self.roundRectButtonPopTipView.dismissTapAnywhere = YES;
				self.roundRectButtonPopTipView.has3DStyle = NO;
				self.roundRectButtonPopTipView.backgroundColor = [UIColor redColor];

				UIButton *button = (UIButton *)weakSender;
				[self.roundRectButtonPopTipView presentPointingAtView:button inView:self.view.superview animated:YES];
			}
			/*else {
				// Dismiss
				[self.roundRectButtonPopTipView dismissAnimated:YES];
				self.roundRectButtonPopTipView = nil;
			}*/
		}];
	}
	if (index%5 == 0) {
		cell.claim.hidden = NO;
		[cell.claim handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
			if (nil == self.roundRectButtonPopTipView) {
				self.roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage:[NSString stringWithFormat:@"Claim at: %@", date]];
				self.roundRectButtonPopTipView.delegate = self;
				self.roundRectButtonPopTipView.dismissTapAnywhere = YES;
				self.roundRectButtonPopTipView.has3DStyle = NO;
				self.roundRectButtonPopTipView.backgroundColor = [UIColor colorWithRed:0.0f green:100.0/255.0f blue:50.0/255.0f alpha:1.0f];

				UIButton *button = (UIButton *)weakSender;
				[self.roundRectButtonPopTipView presentPointingAtView:button inView:self.view.superview animated:YES];
			}/*
			else {
				// Dismiss
				[self.roundRectButtonPopTipView dismissAnimated:YES];
				self.roundRectButtonPopTipView = nil;
			}*/
		}];
	}
	if (index%7 == 0) {
		cell.renewal.hidden = NO;
		[cell.renewal handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
			if (nil == self.roundRectButtonPopTipView) {
				self.roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage:[NSString stringWithFormat:@"Renewal at: %@", date]];
				self.roundRectButtonPopTipView.delegate = self;
				self.roundRectButtonPopTipView.dismissTapAnywhere = YES;
				self.roundRectButtonPopTipView.has3DStyle = NO;
				self.roundRectButtonPopTipView.backgroundColor = [UIColor blueColor];

				UIButton *button = (UIButton *)weakSender;
				[self.roundRectButtonPopTipView presentPointingAtView:button inView:self.view.superview animated:YES];
			}
			/*else {
				// Dismiss
				[self.roundRectButtonPopTipView dismissAnimated:YES];
				self.roundRectButtonPopTipView = nil;
			}*/
		}];
	}
}

- (BOOL)calendarView:(RDVCalendarView *)calendarView shouldSelectCellAtIndex:(NSInteger)index {
	return NO;
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
	if (component == 0) {
		self.calendarView.month.month = row+1;
	}
	else {
		self.calendarView.month.year = 2014+row;
	}

	[self.calendarView setDisplayedMonth:self.calendarView.month];

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	NSString *mthStr = [[df monthSymbols] objectAtIndex:self.calendarView.month.month-1];
	self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"%@ %ld", mthStr, (long)self.calendarView.month.year];
}

#pragma mark CMPopTipViewDelegate methods
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView {
	// User can tap CMPopTipView to dismiss it
	self.roundRectButtonPopTipView = nil;
}

@end
