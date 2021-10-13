//
//  MTViewController.m
//  MTAppCenter
//
//  Created by MTTGCC on 10/13/2021.
//  Copyright (c) 2021 MTTGCC. All rights reserved.
//

#import "MTViewController.h"
#import "MTRouter.h"

@interface MTViewController ()

@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)push:(id)sender {
    [MTRouter openURL:@"product/list" withParams:@{@"1":@"1"} style:0];
}


- (IBAction)pushProductDetails:(id)sender {
    [MTRouter openURL:@"product/details" withParams:@{@"2":@"2"} style:0];
   
}

@end
