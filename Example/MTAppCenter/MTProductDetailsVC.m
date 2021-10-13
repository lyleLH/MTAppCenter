//
//  MTProductDetailsVC.m
//  MTAppCenter_Example
//
//  Created by 刘浩 on 10/13/21.
//  Copyright © 2021 MTTGCC. All rights reserved.
//

#import "MTProductDetailsVC.h"
#import "MTRouter.h"
 



@implementation MTProductDetailsVC

+ (void)load {
    [MTRouter  registerClass:[self class]   forRouter:@"product/details"];
}


- (instancetype)init {
    if(self = [super init]){
        NSLog(@"%@--%@",@"product/details",[MTRouter getArgumentsForKey:self]);
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];


}


@end
