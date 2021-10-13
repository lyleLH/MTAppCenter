///**
/**
MTPlayground
Created by: Tom.Liu on 2021/1/12
Github : https://github.com/lyleLH

 	 * ⣿⣿⣿⣿⣿⣿⢟⣡⣴⣶⣶⣦⣌⡛⠟⣋⣩⣬⣭⣭⡛⢿⣿⣿⣿⣿
	 * ⣿⣿⣿⣿⠋⢰⣿⣿⠿⣛⣛⣙⣛⠻⢆⢻⣿⠿⠿⠿⣿⡄⠻⣿⣿⣿ 
	 * ⣿⣿⣿⠃⢠⣿⣿⣶⣿⣿⡿⠿⢟⣛⣒⠐⠲⣶⡶⠿⠶⠶⠦⠄⠙⢿ 
	 * ⣿⠋⣠⠄⣿⣿⣿⠟⡛⢅⣠⡵⡐⠲⣶⣶⣥⡠⣤⣵⠆⠄⠰⣦⣤⡀ 
	 * ⠇⣰⣿⣼⣿⣿⣧⣤⡸⢿⣿⡀⠂⠁⣸⣿⣿⣿⣿⣇⠄⠈⢀⣿⣿⠿ 
	 * ⣰⣿⣿⣿⣿⣿⣿⣿⣷⣤⣈⣙⠶⢾⠭⢉⣁⣴⢯⣭⣵⣶⠾⠓⢀⣴
	 * ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣉⣤⣴⣾⣿⣿⣦⣄⣤⣤⣄⠄⢿⣿
	 * ⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠈⢿
	 * ⣿⣿⣿⣿⣿⣿⡟⣰⣞⣛⡒⢒⠤⠦⢬⣉⣉⣉⣉⣉⣉⣉⡥⠴⠂⢸
	 * ⠻⣿⣿⣿⣿⣏⠻⢌⣉⣉⣩⣉⡛⣛⠒⠶⠶⠶⠶⠶⠶⠶⠶⠂⣸⣿
	 * ⣥⣈⠙⡻⠿⠿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⠿⠛⢉⣠⣶⣶⣿⣿
	 * ⣿⣿⣿⣶⣬⣅⣒⣒⡂⠈⠭⠭⠭⠭⠭⢉⣁⣄⡀⢾⣿⣿⣿⣿⣿⣿

*/

#import "UIViewController+YKToast.h"
#import <Toast/Toast.h>
#import "UIColor+YKExtension.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIViewController (YKToast)
- (void)yk_toastMessage:(NSString *)tips {
    [self yk_toastMessage:tips duration:2.0 position:kYKToastPositionType_Center];
}

- (void)yk_toastMessage:(NSString *)tips duration:(NSTimeInterval)duration   {
    [self yk_toastMessage:tips duration:duration position:kYKToastPositionType_Center];
}

- (void)yk_toastMessage:(NSString *)tips duration:(NSTimeInterval)duration  position:(kYKToastPositionType)position {
    id hudPosition;
    switch (position) {
        case kYKToastPositionType_Top:
            hudPosition =  CSToastPositionTop;
            break;
        case kYKToastPositionType_Center:
            hudPosition =  CSToastPositionCenter;
            break;
        case kYKToastPositionType_Bottom:
            hudPosition =  CSToastPositionBottom;
            break;
        default:
            break;
    }
    [self.view makeToast:tips duration:duration position:hudPosition ];
}



- (void)yk_toastDetailsTipWithTitle:(NSString *)title  content:(NSString *)content image:(NSString *)imageName duration:(NSTimeInterval)duration  position:(kYKToastPositionType)position completion:(void(^)(BOOL ))completion
{
    id hudPosition;
    switch (position) {
        case kYKToastPositionType_Top:
            hudPosition =  CSToastPositionTop;
            break;
        case kYKToastPositionType_Center:
            hudPosition =  CSToastPositionCenter;
            break;
        case kYKToastPositionType_Bottom:
            hudPosition =  CSToastPositionBottom;
            break;
        default:
            break;
    }
    CSToastStyle * style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.maxWidthPercentage = 1.0;
    style.backgroundColor = [UIColor whiteColor];
    style.horizontalPadding = 10;
    style.imageSize = CGSizeMake(44, 44);
    style.titleColor = [UIColor yk_colorWithHex:0x141938];
    style.messageColor = [UIColor yk_colorWithHex:0xA4AEB7];
    [self.view makeToast:content duration:duration position:hudPosition title:title image:[UIImage imageNamed:imageName] style:style completion:completion];
}


 

@end
