//
//  MTProcutListViewController.m
//  MTAppCenter_Example
//
//  Created by 刘浩 on 10/13/21.
//  Copyright © 2021 MTTGCC. All rights reserved.
//

#import "MTProcutListViewController.h"

@interface MTProcutListViewController ()

@end

@implementation MTProcutListViewController

+ (void)load {
    [MTRouter  registerClass:[self class]   forRouter:@"product/list"];
}

- (void)dealloc {
    
}

- (instancetype)init {
    self = [super init];
    if(self){
        NSLog(@"%@--%@",@"product/list",[MTRouter  getArgumentsForKey:self]);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setFrame:CGRectMake((self.view.frame.size.width -100)* 0.5, 200, 100, 44)];
    [button setTitle:@"去到详情" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushDetails) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pushDetails {
    [MTRouter openURL:@"product/list" withParams:@{@"2":@"2"} style:0] ;
}
 

@end
