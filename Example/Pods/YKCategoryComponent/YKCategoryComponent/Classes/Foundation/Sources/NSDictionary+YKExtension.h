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

@interface NSDictionary (YKExtension)


////////////////////////////////////////////////////////////////
//MARK:-
//MARK:- 更安全的操作
//MARK:-
////////////////////////////////////////////////////////////////






//是否有key
- (BOOL)yk_hasKey:(id)key;

//赋值
- (void)yk_safeSetValue:(id)value forKey:(id)key;

//取值
- (id)yk_safeValueForKey:(id)key;

- (NSString*)yk_stringForKey:(id)key;
- (NSNumber*)yk_numberForKey:(id)key;
- (NSArray*)yk_arrayForKey:(id)key;
- (NSDictionary*)yk_dictionaryForKey:(id)key;

- (NSInteger)yk_integerForKey:(NSString *)pKey;
- (NSUInteger)yk_unsignedIntegerForKey:(NSString *)pKey;
- (float)yk_floatForKey:(NSString *)pKey;
- (double)yk_doubleForKey:(NSString *)pKey;
- (BOOL)yk_boolForKey:(NSString *)pKey;

- (CGRect)yk_rectForKey:(NSString *)pKey;
- (CGSize)yk_sizeForKey:(NSString *)pKey;
- (CGPoint)yk_pointForKey:(NSString *)pKey;


//合并
+ (NSMutableDictionary *)yk_safeDictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSMutableDictionary *)yk_safeDictionaryByMergingWith:(NSDictionary *)dict;


//转换为json字符串
- (NSString *)yk_safeJSONString;

//删除元素
- (NSDictionary *)yk_safeDictionaryRemoveObjectForKey:(id)key;

//遍历字典转化修改
- (NSDictionary *)yk_mapDictionaryUsingBlock:(id (^)(id object, NSString *key))block;

//筛选符合条件的键值对
- (NSDictionary *)yk_filterDictionaryUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind;

//删除符合条件的元素
- (NSDictionary *)yk_deleteDictionaryUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;

@end

NS_ASSUME_NONNULL_END
