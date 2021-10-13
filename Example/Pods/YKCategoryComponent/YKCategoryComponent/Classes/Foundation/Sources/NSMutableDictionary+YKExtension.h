///**
/**
Categoties
Created by: Tom.Liu on 2021/1/4
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (YKExtension)
//对象赋值
- (void)yk_safeSetObject:(id)object forKey:(id)key;

//基本类型赋值
- (void)yk_safeSetBoolObject:(BOOL)number forKey:(id)key ;
- (void)yk_safeSetIntObject:(int)number forKey:(id)key ;
- (void)yk_safeSetIntegerObject:(NSInteger)number forKey:(id)key ;
- (void)yk_safeSetUnsignedIntegerObject:(NSUInteger)number forKey:(id)key ;
- (void)yk_safeSetCharObject:(char)c forKey:(id)key ;
- (void)yk_safeSetDoubleObject:(double)number forKey:(id)key ;
- (void)yk_safeSetFloatObject:(float)number forKey:(id)key ;
- (void)yk_safeSetLongLongObject:(long long)number forKey:(id)key ;
- (void)yk_safeSetCGFloatObject:(CGFloat)f forKey:(id)key ;
- (void)yk_safeSetPointObject:(CGPoint)point forKey:(id)key ;
- (void)yk_safeSetSizeObject:(CGSize)size forKey:(id)key ;
- (void)yk_safeSetRectObject:(CGRect)rect forKey:(id)key ;

//删除元素
- (void)yk_safeRemoveObjectForKey:(id)key ;
//遍历字典转化修改
- (void)yk_mapUsingBlock:(id (^)(id object, NSString *key))block ;
//筛选符合条件的键值对
- (void)yk_filterUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind;
//删除符合条件的元素
- (void)yk_deleteUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;
@end

NS_ASSUME_NONNULL_END
