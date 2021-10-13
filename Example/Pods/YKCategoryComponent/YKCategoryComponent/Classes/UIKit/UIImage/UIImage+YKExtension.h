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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YKExtension)

/// 把图片转换成base64编码的字符串
- (NSString *)yk_toBase64;
/// 生成一个指定尺寸的渐变色的图片对象
/// @param size 指定尺寸
/// @param leftColor 渐变色开始颜色
/// @param rightColor 渐变色结束颜色
+ (UIImage *)imageWithSize:(CGSize)size leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor ;

/// 绘制线性的渐变色路径
/// @param context 上下文
/// @param path 渐变路径
/// @param startColor 开始颜色
/// @param endColor 结束颜色
+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor ;


/// 用随机颜色生成一个 44x44大小的Image对象
+ (UIImage *)yk_randomColorImage ;
/// 用随机颜色生成一个指定size的Image对象
/// @param size 图片的尺寸
+ (UIImage *)yk_fixedSizeRandomColorImageWithSize:(CGSize)size ;


/// 指定颜色和尺寸生成 Image
/// @param color 指定颜色
/// @param size 指定尺寸
+ (UIImage *)yk_colorImageWithColor:(UIColor *)color andSize:(CGSize)size;

/// 将某个图片对象 缩放到某个指定的尺寸 （需要对大小进行压缩时候可能用到）
/// @param img 图片对象
/// @param size 指定的尺寸
+(UIImage *)yk_scaleImage:(UIImage *)img toSize:(CGSize)size ;
/**
 *  压缩图片质量，返回值为可直接转化成UIImage对象的NSData对象
 *  aimLength: 目标大小，单位：字节（b）
 *  accuracyOfLength: 压缩控制误差范围(+ / -)，本方法虽然给出了误差范围，但实际上很难确定一张图片是否能压缩到误差范围内，无法实现精确压缩。
 */
+ (NSData *)yk_compressImageWithImage:(UIImage *)image aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy ;
/*
 * 裁剪图片
 */
- (UIImage *)yk_cropImageWithX:(CGFloat)x
                          y:(CGFloat)y
                      width:(CGFloat)width
                        height:(CGFloat)height;


/// 图片尺比例不变的情况下，缩放其尺寸，按宽或者高来充满屏幕显示，
/// @param image 需要缩放的图片
+ (UIImage *)yk_fitScreenWithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
