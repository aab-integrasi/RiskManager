//
//  ISMainTableViewController.h
//  Astra
//
//  Created by Soemarko Ridwan on 8/1/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISMainTableViewController : UITableViewController

@property (strong, nonatomic) UIViewController *detailView;
@property (nonatomic, retain) NSArray *items;

@end
