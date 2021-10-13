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

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YKExtension)

- (id)yk_firstObject;

- (id)yk_lastObject;


/// 从母数组中移除子数组中的对象后的对象数组
/// @param pArray 要移除的对象数组
- (NSArray *)yk_arrayByRemovingObjectsFromArray:(NSArray *)pArray;

/// ///从母数组中取得某个类的全部对象 后的数组
/// @param pClass 要筛选出来的对象所属的类
- (NSArray *)yk_allObjectsWithKindOfClass:(Class)pClass;

/// 数组中对象类型为某个类型的第一个对象
/// @param pClass 标定的类型
- (id)yk_firstObjectWithKindOfClass:(Class)pClass;

/// ///遍历数组中每一个其类型目标类型的对象 并回调
/// @param pClass 标定的类型
/// @param pBlock 回调
- (void)yk_enumerateObjectsWithKindOfClass:(Class)pClass usingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))pBlock;



////////////////////////////////////////////////////////////////
//MARK:-
//MARK:- 更安全的操作
//MARK:-
////////////////////////////////////////////////////////////////


+ (BOOL)yk_isEmptyWithArray:(NSArray *)array ;

- (id)yk_safeObjectAtIndex:(NSInteger)index ;

///取随机元素
- (id)yk_randomObject ;
///添加
- (NSMutableArray *)yk_safeAddObject:(id)object ;
///删除元素
- (NSMutableArray *)yk_safeArrayRemoveObjectAtIndex:(NSInteger)index ;
///转换
- (NSArray *)yk_mapArrayUsingBlock:(id (^)(id, NSInteger))block ;
///筛选
- (NSArray *)yk_filterArrayUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind ;
///删除符合条件的元素
- (NSArray *)yk_deleteArrayUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete ;
///数组乱序
- (NSArray *)yk_shuffledArray ;
///数组倒序
- (NSArray *)yk_reversedArray ;
///数组去重
- (NSArray *)yk_uniqueArray ;
@end

NS_ASSUME_NONNULL_END
