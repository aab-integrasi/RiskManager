//
//  ISHomeViewController.h
//  Astra
//
//  Created by Soemarko Ridwan on 8/1/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVCalendarViewController.h"
#import "CMPopTipView.h"

@interface ISHomeViewController : RDVCalendarViewController <UIPickerViewDataSource, UIPickerViewDelegate, CMPopTipViewDelegate>

@property (nonatomic,retain) UIPickerView *picker;
@property (nonatomic, retain) CMPopTipView *roundRectButtonPopTipView;

@end
