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

#import "NSMutableDictionary+YKExtension.h"

@implementation NSMutableDictionary (YKExtension)
//对象赋值
- (void)yk_safeSetObject:(id)object forKey:(id)key {
    if (key && object) {
        [self setObject:object forKey:key];
    }
}

//基本类型赋值
- (void)yk_safeSetBoolObject:(BOOL)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)yk_safeSetIntObject:(int)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}


- (void)yk_safeSetIntegerObject:(NSInteger)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}


- (void)yk_safeSetUnsignedIntegerObject:(NSUInteger)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}

- (void)yk_safeSetCharObject:(char)c forKey:(id)key {
    if (key) {
        [self setObject:@(c) forKey:key];
    }
}
- (void)yk_safeSetDoubleObject:(double)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)yk_safeSetFloatObject:(float)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}
- (void)yk_safeSetLongLongObject:(long long)number forKey:(id)key {
    if (key) {
        [self setObject:@(number) forKey:key];
    }
}

- (void)yk_safeSetCGFloatObject:(CGFloat)f forKey:(id)key {
    if (key) {
        [self setObject:@(f) forKey:key];
    }
}

- (void)yk_safeSetPointObject:(CGPoint)point forKey:(id)key {
    if (key) {
        [self setObject:NSStringFromCGPoint(point) forKey:key];
    }
}
- (void)yk_safeSetSizeObject:(CGSize)size forKey:(id)key {
    if (key) {
        [self setObject:NSStringFromCGSize(size) forKey:key];
    }
}
- (void)yk_safeSetRectObject:(CGRect)rect forKey:(id)key {
    if (key) {
        [self setObject:NSStringFromCGRect(rect) forKey:key];
    }
}

//删除元素
- (void)yk_safeRemoveObjectForKey:(id)key {
    if (key) {
        [self removeObjectForKey:key];
    }
}

//遍历字典转化修改
- (void)yk_mapUsingBlock:(id (^)(id object, NSString *key))block{
    
    if (block) {
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self yk_safeSetObject:block(obj, key) forKey:key];
        }];
    }
    
}

//筛选符合条件的键值对
- (void)yk_filterUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind {
    
    if (findBlock) {
        __block NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (findBlock (obj, key)) {
                [dict yk_safeSetObject:obj forKey:key];
                *stop = stopWhenFind;
            }
        }];
        [self removeAllObjects];
        [self setDictionary:dict];
    }
}

//删除符合条件的元素
- (void)yk_deleteUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *keys = [NSMutableArray array];
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (deleteBlock(obj,key)) {
                [keys addObject:key];
                *stop = stopWhenDelete;
            }
        }];
        [self removeObjectsForKeys:keys];
    }
}


@end
