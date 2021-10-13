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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


// MB默认的HUD
typedef NS_ENUM(NSUInteger, kYKHudType) {
    kYKHudType_Text,
    kYKHudType_Activity,
    kYKHudType_TextWithActivity,
};

// 使用MB的自定义类型 实现的HUD
typedef NS_ENUM(NSUInteger, kYKCustomizedHudType) {
    
    kYKCustomizedHudType_Info, // with icon !
    kYKCustomizedHudType_Success, // with icon  ✕
    kYKCustomizedHudType_Error, //  with icon  ✓
};

/// !!! TODO:

@interface UIViewController (YKHud)

/// 自动消失的纯文字HUD
- (void)yk_showTextHUD;

/// 持续转圈圈
- (void)yk_showActivityHUD;

///持续转圈圈 加持续的文字提示
- (void)yk_showActivityHUDWithText:(NSString *)text ;

/// 隐藏持续性的HUD
- (void)yk_hideHUD;

/// 错误提示、自动消失、自定义错误的icon
/// @param error 错误信息字符串
- (void)yk_showError:(NSString *)error;

/// 成功提示、自动消失、自定义 成功的icon
/// @param success 成功的消息字符串
- (void)yk_showSuccess:(NSString *)success;

/// 信息提示、自动消失、自定义提醒的icon
/// @param info 信息提示字符串
- (void)yk_showInfo:(NSString *)info;


@end

NS_ASSUME_NONNULL_END
