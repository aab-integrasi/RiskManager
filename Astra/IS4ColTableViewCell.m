//
//  IS4ColTableViewCell.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/10/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "IS4ColTableViewCell.h"

@implementation IS4ColTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		_label1 = [[UILabel alloc] init];
		_label2 = [[UILabel alloc] init];
		_label3 = [[UILabel alloc] init];
		_label4 = [[UILabel alloc] init];

		/*CGFloat fontSize = 13.0;

		 _label1.font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
		 _label2.font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
		 _label3.font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
		 _label4.font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
		 _label5.font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
		 _label6.font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];*/

		_label1.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
		_label2.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
		_label3.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
		_label4.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];

		_label1.translatesAutoresizingMaskIntoConstraints = NO;
		_label2.translatesAutoresizingMaskIntoConstraints = NO;
		_label3.translatesAutoresizingMaskIntoConstraints = NO;
		_label4.translatesAutoresizingMaskIntoConstraints = NO;

		_containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
		[_containerView addSubview:_label1];
		[_containerView addSubview:_label2];
		[_containerView addSubview:_label3];
		[_containerView addSubview:_label4];

		[_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:FOURCOLCONSTRAINT options:NSLayoutFormatAlignAllCenterY metrics:@{@"leftMargin": @15} views:NSDictionaryOfVariableBindings(_label1, _label2, _label3, _label4)]];
		[_containerView addConstraint:[NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];

		[self addSubview:_containerView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
