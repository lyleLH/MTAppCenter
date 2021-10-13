//
//  MTRouter.h
//  MTAppCenter_Example
//
//  Created by 刘浩 on 10/13/21.
//  Copyright © 2021 MTTGCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTRouterProrocol.h"
#import "MTBaseViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTRouter : NSObject <MTBaseViewControllerRouterDelegate>

+ (void)registerClass:(Class)class  forRouter:(NSString *)router;

+ (void)openURL:(NSString *)url withParams:(NSDictionary*)params  style:(NSInteger)style;
+ (NSDictionary *)getArgumentsForKey:(NSObject *)key;

+ (NSMapTable *)getArgumentsTable;

@end

NS_ASSUME_NONNULL_END
