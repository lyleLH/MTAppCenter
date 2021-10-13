//
//  MTRouter.m
//  MTAppCenter_Example
//
//  Created by 刘浩 on 10/13/21.
//  Copyright © 2021 MTTGCC. All rights reserved.
//

#import "MTRouter.h"
#import <MTCategoryComponent/MTCategoryComponentHeader.h>
#import "MTBaseViewController.h"
 


static NSMapTable <NSObject *,NSDictionary *>* _routerParams;


@implementation MTRouter


+(void)load {
    _routerParams = [NSMapTable weakToWeakObjectsMapTable];
}



+ (void)registerClass:(Class)class   forRouter:(NSString *)router {
    
    [[self routers] setValue:class forKey:router];
}

+ (NSMutableDictionary <NSString*,Class>*)routers {
    static NSMutableDictionary *routers;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routers = [NSMutableDictionary new];
    });
    return routers;
}
 

+ (void)openURL:(NSString *)url withParams:(NSDictionary*)params  style:(NSInteger)style {
    Class class = [[self routers] valueForKey:url];
    
    MTBaseViewController * vc_alloc =  [[class class] alloc];
    [_routerParams setObject:params forKey:vc_alloc];
    MTBaseViewController * vc_init = [vc_alloc init];
    
    [[UIViewController mt_topViewController] presentViewController:vc_init animated:YES completion:nil];
 
}


+ (NSDictionary *)getArgumentsForKey:(NSObject *)key {
    NSLog(@"_routerParams.count --  %ld",_routerParams.count);
    return [_routerParams objectForKey:key];
}

+ (NSMapTable *)getArgumentsTable {
    return _routerParams;
}
 



@end
