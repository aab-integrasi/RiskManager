//
//  ISCalendarCell.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/10/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISCalendarCell.h"
#import "ALActionBlocks.h"

@implementation ISCalendarCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
		_offRisk = [UIButton buttonWithType:UIButtonTypeSystem];
		_claim = [UIButton buttonWithType:UIButtonTypeSystem];
		_renewal = [UIButton buttonWithType:UIButtonTypeSystem];

		_offRisk.hidden = YES;
		_claim.hidden = YES;
		_renewal.hidden = YES;

		_offRisk.tintColor = [UIColor redColor];
		_claim.tintColor = [UIColor colorWithRed:0.0f green:100.0/255.0f blue:50.0/255.0f alpha:1.0f];
		_renewal.tintColor = [UIColor blueColor];

		[self.contentView addSubview:_offRisk];
		[self.contentView addSubview:_claim];
		[self.contentView addSubview:_renewal];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];

	self.textLabel.font = [UIFont systemFontOfSize:20.0f];
	self.textLabel.textAlignment = NSTextAlignmentRight;
	CGSize viewSize = self.frame.size;
	self.textLabel.frame = CGRectMake(viewSize.width-50, 20, 30, 20);

	[_offRisk setTitle:@"O" forState:UIControlStateNormal];
	[_claim setTitle:@"C" forState:UIControlStateNormal];
	[_renewal setTitle:@"R" forState:UIControlStateNormal];

	_offRisk.frame = CGRectMake(15, viewSize.height-30, 20, 20);
	_claim.frame = CGRectMake(_offRisk.frame.origin.x+30, viewSize.height-30, 20, 20);
	_renewal.frame = CGRectMake(_claim.frame.origin.x+30, viewSize.height-30, 20, 20);
}

- (void)prepareForReuse {
	[super prepareForReuse];

	self.textLabel.textColor = [UIColor blackColor];
	_offRisk.hidden = YES;
	_claim.hidden = YES;
	_renewal.hidden = YES;

	[_offRisk removeActionBlocksForControlEvents:UIControlEventTouchUpInside];
	[_claim removeActionBlocksForControlEvents:UIControlEventTouchUpInside];
	[_renewal removeActionBlocksForControlEvents:UIControlEventTouchUpInside];
}

@end
