//
//  ISEventOffriskTableViewController.h
//  Astra
//
//  Created by Soemarko Ridwan on 8/9/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISEventOffriskTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,retain) UIPickerView *picker;

@property (nonatomic, retain) NSArray *items;

@end
