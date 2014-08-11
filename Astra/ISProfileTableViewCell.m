//
//  ISProfileTableViewCell.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/7/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISProfileTableViewCell.h"

@implementation ISProfileTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		_label1 = [[UILabel alloc] init];
		_label2 = [[UILabel alloc] init];

		_label1.frame = CGRectMake(20, 1, 135, 44);
		_label2.frame = CGRectMake(160, 0, 350, 44);

		_label1.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
		//_label1.textAlignment = NSTextAlignmentRight;

		[self addSubview:_label1];
		[self addSubview:_label2];
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
