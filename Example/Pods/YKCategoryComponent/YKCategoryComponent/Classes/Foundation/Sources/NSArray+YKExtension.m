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

#import "NSArray+YKExtension.h"
#import "NSMutableArray+YKExtension.h"
@implementation NSArray (YKExtension)

- (id)yk_firstObject {
    if([self count] == 0) {
        return nil;
    }
    return [self objectAtIndex:0];
}

- (id)yk_lastObject {
    if([self count] == 0) {
        return nil;
    }
    return [self objectAtIndex:[self count] - 1];
}

- (NSArray *)yk_arrayByRemovingObjectsFromArray:(NSArray *)pArray {
    NSMutableArray *array = [self mutableCopy];
    [array removeObjectsInArray:pArray];
    return array;
}

- (NSArray *)yk_allObjectsWithKindOfClass:(Class)pClass {
    NSMutableArray *objects = [NSMutableArray array];
    for(id object in self) {
        if([object isKindOfClass:pClass]) {
            [objects addObject:object];
        }
    }
    return objects;
}

- (id)yk_firstObjectWithKindOfClass:(Class)pClass {
    for(id object in self) {
        if([object isKindOfClass:pClass]) {
            return object;
        }
    }
    return nil;
}


- (void)yk_enumerateObjectsWithKindOfClass:(Class)pClass usingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))pBlock {
    if(pBlock == nil) {
        return;
    }
    BOOL stop = NO;
    for(NSInteger i = 0; i < [self count]; ++i) {
        id object = [self objectAtIndex:i];
        if([object isKindOfClass:pClass]) {
            pBlock(object, i, &stop);
        }
        if(stop) {
            break;
        }
    }
}


////////////////////////////////////////////////////////////////
//MARK:-
//MARK:- 更安全的操作
//MARK:-
////////////////////////////////////////////////////////////////



+ (BOOL)yk_isEmptyWithArray:(NSArray *)array {
    if (array && (array.count > 0)) {
        return NO;
    }
    return YES;
}

- (id)yk_safeObjectAtIndex:(NSInteger)index {
    if ((self.count > index) && (index >= 0)) {
        id obj = [self objectAtIndex:index];
        if (![obj isKindOfClass:[NSNull class]]) {
            return obj;
        }
    }
    NSLog(@"注意-------------->数组越界");
    return nil;
}

//取随机元素
- (id)yk_randomObject {
    if (self && self.count > 0) {
        NSInteger index = arc4random() % self.count;
        return [self yk_safeObjectAtIndex:index];
    }
    return nil;
}

//添加
- (NSMutableArray *)yk_safeAddObject:(id)object {
    NSMutableArray *mutArray = [NSMutableArray array];
    
    if (self) {
        [mutArray yk_safeAddObjectsFromArray:self];
    }
    [mutArray yk_safeAddObject:object];
    return mutArray;

}
//删除元素
- (NSMutableArray *)yk_safeArrayRemoveObjectAtIndex:(NSInteger)index {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    [array yk_safeRemoveObjectAtIndex:index];
    return array;
}

//转换
- (NSArray *)yk_mapArrayUsingBlock:(id (^)(id, NSInteger))block {
    
    if (block) {
        __block NSMutableArray *array = [NSMutableArray array];
        
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array yk_safeAddObject:block(obj, idx)];
        }];
        return [array copy];
    }
    return self;
}

//筛选
- (NSArray *)yk_filterArrayUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind {
    
    if (findBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (findBlock(obj)) {
                [array yk_safeAddObject:obj];
                *stop = stopWhenFind;
            }
        }];
        
        return [array copy];
    }
    return self;
}

//删除符合条件的元素
- (NSArray *)yk_deleteArrayUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray yk_safeAddObjectsFromArray:self];
        
        [mutArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (deleteBlock(obj)) {
                [array yk_safeAddObject:obj];
                *stop = stopWhenDelete;
            }
        }];
        [mutArray removeObjectsInArray:[array copy]];
        return [mutArray copy];
    }
    
    return self;
}

//数组乱序
- (NSArray *)yk_shuffledArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    NSMutableArray *copy = [self mutableCopy];
    while (copy.count > 0)
    {
        NSInteger index = arc4random() % copy.count;
        id objectToMove = [copy objectAtIndex:index];
        [array addObject:objectToMove];
        [copy removeObjectAtIndex:index];
    }
    return [array copy];
}

//数组倒序
- (NSArray *)yk_reversedArray {
    NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
    return reversedArray;
}

//数组去重
- (NSArray *)yk_uniqueArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([array containsObject:obj] == NO){
            [array addObject:obj];
        }
    }];
    return [array copy];
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level
{
    // 定义用于拼接字符串的容器
    NSMutableString *stringM = [NSMutableString string];
    
    // 拼接开头
    [stringM appendString:@"(\n"];
    
    // 拼接中间的数组元素
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [stringM appendFormat:@"\t%@,\n",obj];
        
    }];
    
    // 拼接结尾
    [stringM appendString:@")\n"];
    
    return stringM;
}

@end
