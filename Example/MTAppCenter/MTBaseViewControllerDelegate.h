//
//  MTBaseViewControllerDelegate.h
//  MTAppCenter_Example
//
//  Created by 刘浩 on 10/13/21.
//  Copyright © 2021 MTTGCC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

 
@protocol MTBaseViewControllerRouterDelegate <NSObject>
+ (NSDictionary *)getArguments;



@end
 

NS_ASSUME_NONNULL_END
