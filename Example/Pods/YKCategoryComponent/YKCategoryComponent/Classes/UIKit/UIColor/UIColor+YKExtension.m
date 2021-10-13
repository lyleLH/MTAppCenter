///**
/**
Categoties
Created by: Tom.Liu on 2021/1/8
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

#import "UIColor+YKExtension.h"

@implementation UIColor (YKExtension)


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 常用的颜色方法
//MARK:-
////////////////////////////////////////////////////////////////

///随机色，饱和度低比较美观的随机颜色
+ (UIColor *)yk_randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.2; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.4; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

///易于阅读的随机颜色对，<前景色、文字色 - 背景色>
+ (NSArray * )yk_randomPairColorForRead {
    NSArray * pairs= @[@[@"#F1FAFA",@"#000000"]
                       ,@[@"#E8FFE8",@"#000000"]
                       ,@[@"#8080C0",@"#FFFF04"]
                       ,@[@"#E8D098",@"#0700FF"]
                       ,@[@"#EFEFDA",@"#FF0201"]
                       
                       ,@[@"#F2F1D7",@"#000000"]
                       ,@[@"#336699",@"#FFFFFF"]
                       ,@[@"#6699CC",@"#FFFFFF"]
                       ,@[@"#66CCCC",@"#FFFFFF"]
                       
                       ,@[@"#B45B3E",@"#FFFFFF"]
                       ,@[@"#479AC7",@"#FFFFFF"]
                       ,@[@"#00B271",@"#FFFFFF"]
                       ,@[@"#FBFBEA",@"#000000"]
                       
                       ,@[@"#D5F3F4",@"#000000"]
                       ,@[@"#D7FFF0",@"#000000"]
                       ,@[@"#F0DAD2",@"#000000"]
                       ,@[@"#DDF3FF",@"#000000"]
                       ];
    
    
    NSInteger l = pairs.count;
    NSInteger index  = ( arc4random() % l);
    return pairs[index];
}

/// 根据 hex字符串<"#123456">返回 UIcolor
/// @param hexString @"#1abc9c"],@"1abc9c"],@"#1ABC9C"]，不区分大小写自动过滤'#'
+ (UIColor *)yk_colorFromHexString:(NSString *)hexString  {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

/// hex值返回UIcolor
/// @param hexValue 0x666666
+ (UIColor *)yk_colorWithHex:(int)hexValue {
    return [UIColor yk_colorWithHex:hexValue alpha:1.0];
}

/// hex值返回UIcolor
/// @param hexValue  0x666666
/// @param alpha 0～1.0
+ (UIColor *)yk_colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}


/// 设置RGBA的值生成UIColor对象,Alpha =1.0
/// @param R Red  ：小数值，(0-255)/255.0
/// @param G Green：小数值，(0-255)/255.0
/// @param B Blue ：小数值，(0-255)/255.0
+ (UIColor *)yk_colorRGB:(CGFloat)R g:(CGFloat)G b:(CGFloat)B {
    return [self yk_colorRGBA:R g:G b:B A:1.0];
}
/// 设置RGBA的值生成UIColor对象
/// @param R Red  ：正数，(0-255)
/// @param G Green：正数，(0-255)
/// @param B Blue ：正数，(0-255)
/// @param alpha Alpha ：小数值，0-1.0
+ (UIColor *)yk_colorRGBA:(CGFloat)R g:(CGFloat)G b:(CGFloat)B A:(CGFloat)alpha {
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
}

 


//+ (UIColor *)yk_gradientColorWithLeftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor {
//    return  [UIColor colorWithPatternImage:[UIImage imageWithSize:CGSizeMake(200, 50) leftColor:leftColor rightColor:rightColor]];
//}

+ (UIColor*)yk_colorFromImage:(UIImage *)imageIn fillInView:(UIView *)view {
    
    UIGraphicsBeginImageContext(view.frame.size);
    [imageIn drawInRect:view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  [UIColor colorWithPatternImage:image];
    
}
 




#pragma mark -- App颜色配置

+ (UIColor *)yk_normalTextColor {
    return [UIColor yk_colorWithHex:0x333333 alpha:1.0];
    
}

+ (UIColor *)yk_normalTextRedColor {
    return [UIColor yk_colorWithHex:0xB23333 alpha:1.0];
    
}
 


+ (UIColor *)yk_sytAppThemeColor {
    return  [UIColor yk_colorFromHexString:@"#008CFF"];
}


+ (UIColor *)yk_themeGradientLeftColor {
    return  [UIColor yk_colorFromHexString:@"#1F9EFF"];
}

/// 主题色按钮 禁用状态的颜色 渐变   ，左边的颜色
+ (UIColor *)yk_themeDisabledGradientLeftColor {
    return  [UIColor yk_colorFromHexString:@"#1F9EFF"];
}


/// 主题色按钮 禁用状态的颜色 渐变   ，右边的颜色
+ (UIColor *)yk_themeDisabledGradientRightColor {
    return  [UIColor yk_colorFromHexString:@"#1F9EFF"];
}




+ (UIColor *)yk_themeGradientRightColor {
    return  [UIColor yk_colorFromHexString:@"#027AFF"];
}


+ (UIColor *)yk_disabledInWhiteBgTextColor{
    return  [UIColor yk_colorFromHexString:@"#626F7F"];
}

+ (UIColor *)yk_normalInWhiteBgTextColor {
    return  [UIColor yk_colorFromHexString:@"#0F1D2E"];
}


+ (UIColor *)yk_normalInWhiteBgseparateLineColor {
    return  [UIColor yk_colorFromHexString:@"#E7EDF2"];
}

+ (UIColor *)yk_lightBlueBgColor {
    return  [UIColor yk_colorFromHexString:@"#E1EFFA"];
}


+ (UIColor *)yk_lightGrayBlueBgColor {
    return  [UIColor yk_colorFromHexString:@"#F9FBFC"];
}

+ (UIColor *)yk_commonViewBgColor {
    return  [UIColor yk_colorFromHexString:@"#F1F6FA"];
}





#pragma  mark -- 收款页面数字键盘 相关的颜色

+ (UIColor *)yk_numpadNumbersBackgroundColor {
    return  [UIColor yk_colorFromHexString:@"#F1F6FA"];
}


+ (UIColor *)yk_numpadFunctionsBackgroundColor {
    return  [UIColor yk_colorFromHexString:@"#E5F3FF"];
}



@end
