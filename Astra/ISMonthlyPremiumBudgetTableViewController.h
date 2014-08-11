//
//  ISMonthlyPremiumBudgetTableViewController.h
//  Astra
//
//  Created by Soemarko Ridwan on 8/10/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISMonthlyPremiumBudgetTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic) int selectedMonth;
@property (nonatomic) int selectedYear;
@property (nonatomic, retain) NSArray *items;

@end
