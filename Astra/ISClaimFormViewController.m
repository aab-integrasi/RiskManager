//
//  ISClaimFormViewController.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/14/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "XLForm.h"
#import "ISClaimFormViewController.h"

@interface ISClaimFormViewController ()

@end

@implementation ISClaimFormViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}*/

- (id)init {
	XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:@"Quick Claim"];
	XLFormSectionDescriptor * section;
	XLFormRowDescriptor * row;

	section = [XLFormSectionDescriptor formSection];
	//section.footerTitle = @"";
	[form addFormSection:section];

	row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Nama" rowType:XLFormRowDescriptorTypeText title:@"Name"];
	row.required = YES;
	[section addFormRow:row];

	return [super initWithForm:form];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
