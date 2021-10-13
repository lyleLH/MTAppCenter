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

#import "NSMutableArray+YKExtension.h"
#import "NSArray+YKExtension.h"
@implementation NSMutableArray (YKExtension)

//添加id数组元素
- (void)yk_safeAddObject:(id)object {
    if (object) {
        [self addObject:object];
    }
}

//从数组里添加元素
- (void)yk_safeAddObjectsFromArray:(NSArray *)array {
    if (array) {
        [self addObjectsFromArray:array];
    }
}

//插入元素
- (void)yk_safeInsertObject:(id)object atIndex:(NSInteger)index {
    if (object && (self.count > index) && index>=0) {
        [self insertObject:object atIndex:index];
    }
}
//替换
- (void)yk_safeReplaceObjectAtIndex:(NSInteger)index  withObject:(id)object
{
    if (object&&(self.count>index)&&index>=0) {
        [self replaceObjectAtIndex:index withObject:object];
    }
}

//添加基本类型数组元素
- (void)yk_safeAddObjectWithInteger:(NSInteger)number {
    [self yk_safeAddObject:@(number)];
}

- (void)yk_safeAddObjectWithDouble:(double)number {
    [self yk_safeAddObject:@(number)];
}

- (void)yk_safeAddObjectWithFloat:(float)number {
    [self yk_safeAddObject:@(number)];
}

- (void)yk_safeAddObjectWithLong:(long long)number {
    [self yk_safeAddObject:@(number)];
}

- (void)yk_safeAddObjectWithRang:(NSRange)rang{
    [self yk_safeAddObject:NSStringFromRange(rang)];
}

- (void)yk_safeAddObjectWithRect:(CGRect)rect{
    [self yk_safeAddObject:NSStringFromCGRect(rect)];
}

- (void)yk_safeAddObjectWithPoint:(CGPoint)point{
    [self yk_safeAddObject:NSStringFromCGPoint(point)];
}

- (void)yk_safeAddObjectWithSize:(CGSize)size{
    [self yk_safeAddObject:NSStringFromCGSize(size)];
}

//删除元素
- (void)yk_safeRemoveObjectAtIndex:(NSInteger)index {
    
    if ((self.count > index) && (index >= 0)) {
        [self removeObjectAtIndex:index];
    }
}

//转换
- (void)yk_mapUsingBlock:(id (^)(id, NSInteger))block {
    
    if (block) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array yk_safeAddObject:block(obj, idx)];
        }];
        [self removeAllObjects];
        [self yk_safeAddObjectsFromArray:[array copy]];
    }
}

//筛选
- (void)yk_filterUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind {
    
    if (findBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (findBlock(obj)) {
                [array yk_safeAddObject:obj];
                *stop = stopWhenFind;
            }
        }];
        [self removeAllObjects];
        [self yk_safeAddObjectsFromArray:[array copy]];
    }
}

//删除符合条件的元素
- (void)yk_deleteUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (deleteBlock(obj)) {
                [array yk_safeAddObject:obj];
                *stop = stopWhenDelete;
            }
        }];
        [self removeObjectsInArray:[array copy]];
    }
}


//重组数组(打乱顺序)
- (void)yk_shuffle {
    NSMutableArray *copy = [self mutableCopy];
    [self removeAllObjects];
    
    while (copy.count > 0) {
        int index = arc4random() % copy.count;
        id objectToMove = [copy yk_safeObjectAtIndex:index];
        [self yk_safeAddObject:objectToMove];
        [copy yk_safeRemoveObjectAtIndex:index];
    }
}

//数组倒序
- (void)yk_reverse {
    NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
    [self removeAllObjects];
    [self yk_safeAddObjectsFromArray:reversedArray];
}

//数组去重
- (void)yk_unique {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([array containsObject:obj] == NO){
            [array addObject:obj];
        }
    }];
    [self removeAllObjects];
    [self yk_safeAddObjectsFromArray:[array mutableCopy]];
}
@end
