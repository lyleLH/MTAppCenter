//
//  MTBaseViewController.h
//  MTAppCenter_Example
//
//  Created by 刘浩 on 10/13/21.
//  Copyright © 2021 MTTGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBaseViewControllerInterface.h"
#import "MTBaseViewControllerDelegate.h"
#import "MTRouter.h"

NS_ASSUME_NONNULL_BEGIN



@interface MTBaseViewController : UIViewController <MTBaseViewControllerInterface>

//@property (nonatomic,weak) id <MTBaseViewControllerRouterDelegate>delegate;
//
//- (instancetype)initWithDelegate:(id <MTBaseViewControllerRouterDelegate>)delegate ;

@end

NS_ASSUME_NONNULL_END
