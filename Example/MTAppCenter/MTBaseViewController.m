//
//  MTBaseViewController.m
//  MTAppCenter_Example
//
//  Created by 刘浩 on 10/13/21.
//  Copyright © 2021 MTTGCC. All rights reserved.
//

#import "MTBaseViewController.h"
#import "MTBaseViewControllerDelegate.h"

static NSMapTable <NSObject *,NSDictionary *>* _param;

@interface MTBaseViewController ()

@end

@implementation MTBaseViewController



- (void)dealloc {
    NSLog(@"MTBaseViewController dealloc");
    
  
}



+(void)load {
    _param = [NSMapTable weakToWeakObjectsMapTable];
}

+ (void)recievedArguments:(NSDictionary *)param withKey:(nonnull NSObject *)key {
    [_param setObject:param forKey:key];
    NSLog(@"----> []\n%@-- count %ld",_param,_param.count);
}

 
- (NSDictionary *)getArgument {
   
    return [_param objectForKey:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
