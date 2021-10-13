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

@interface NSMutableArray (YKExtension)
///添加id数组元素
- (void)yk_safeAddObject:(id)object;
///从数组里添加元素
- (void)yk_safeAddObjectsFromArray:(NSArray *)array;
///插入元素
- (void)yk_safeInsertObject:(id)object atIndex:(NSInteger)index ;
///替换
- (void)yk_safeReplaceObjectAtIndex:(NSInteger)index  withObject:(id)object;
///添加基本类型数组元素
- (void)yk_safeAddObjectWithInteger:(NSInteger)number;
- (void)yk_safeAddObjectWithDouble:(double)number;
- (void)yk_safeAddObjectWithFloat:(float)number ;
- (void)yk_safeAddObjectWithLong:(long long)number ;
- (void)yk_safeAddObjectWithRang:(NSRange)rang;
- (void)yk_safeAddObjectWithRect:(CGRect)rect;
- (void)yk_safeAddObjectWithPoint:(CGPoint)point;
- (void)yk_safeAddObjectWithSize:(CGSize)size;

///删除元素
- (void)yk_safeRemoveObjectAtIndex:(NSInteger)index ;

///转换
- (void)yk_mapUsingBlock:(id (^)(id, NSInteger))block ;
///筛选
- (void)yk_filterUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind ;
///删除符合条件的元素
- (void)yk_deleteUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;

///重组数组(打乱顺序)
- (void)yk_shuffle;
///数组倒序
- (void)yk_reverse;
///数组去重
- (void)yk_unique;
@end

NS_ASSUME_NONNULL_END
