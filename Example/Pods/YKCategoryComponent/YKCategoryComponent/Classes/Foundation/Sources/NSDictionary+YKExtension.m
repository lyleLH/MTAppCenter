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

#import "NSDictionary+YKExtension.h"
#import "NSMutableDictionary+YKExtension.h"

@implementation NSDictionary (YKExtension)

- (NSInteger)yk_integerForKey:(NSString *)pKey {
    return [[self objectForKey:pKey] integerValue];
}
- (NSUInteger)yk_unsignedIntegerForKey:(NSString *)pKey {
    return [[self objectForKey:pKey] unsignedIntegerValue];
}
- (float)yk_floatForKey:(NSString *)pKey {
    return [[self objectForKey:pKey] floatValue];
}
- (double)yk_doubleForKey:(NSString *)pKey {
    return [[self objectForKey:pKey] floatValue];
}
- (BOOL)yk_boolForKey:(NSString *)pKey {
    return [[self objectForKey:pKey] boolValue];
}

- (CGRect)yk_rectForKey:(NSString *)pKey {
    return CGRectFromString([self objectForKey:pKey]);
}
- (CGSize)yk_sizeForKey:(NSString *)pKey {
    return CGSizeFromString([self objectForKey:pKey]);
}
- (CGPoint)yk_pointForKey:(NSString *)pKey {
    return CGPointFromString([self objectForKey:pKey]);
}



- (BOOL)yk_hasKey:(id)key {
    return [self objectForKey:key] != nil;
}

//赋值
- (void)yk_safeSetValue:(id)value forKey:(id)key {
    if (key && value) {
        [self setValue:value forKey:key];
    }
}


//取值
- (id)yk_safeValueForKey:(id)key {
    if ([self yk_hasKey:key]) {
        id value = [self valueForKey:key];
        if (![value isEqual:[NSNull null]]) {
            return value;
        }
    }
    return nil;
}


- (NSString*)yk_stringForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([[value description] isEqualToString:@"(null)"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

- (NSNumber*)yk_numberForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}


- (NSArray*)yk_arrayForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}


- (NSDictionary*)yk_dictionaryForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

 

 

//合并
+ (NSMutableDictionary *)yk_safeDictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if (![dict1 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary * newVal = [[dict1 objectForKey: key] yk_safeDictionaryByMergingWith: (NSDictionary *) obj];
                if (newVal && key) {
                    [result setObject: newVal forKey: key];
                }
                
            } else {
                if (obj && key) {
                    [result setObject: obj forKey: key];
                }
            }
        }
    }];
    return [result copy];
}

- (NSMutableDictionary *)yk_safeDictionaryByMergingWith:(NSDictionary *)dict {
    return [[self class] yk_safeDictionaryByMerging:self with: dict];
}


//转换为json字符串
- (NSString *)yk_safeJSONString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

//删除元素
- (NSDictionary *)yk_safeDictionaryRemoveObjectForKey:(id)key {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self];
    [dict yk_safeRemoveObjectForKey:key];
    return [dict copy];
}

//遍历字典转化修改
- (NSDictionary *)yk_mapDictionaryUsingBlock:(id (^)(id object, NSString *key))block {
    if (block) {
        __block NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [dict setObject:block(obj, key) forKey:key];
        }];
        return [dict copy];
    }
    return self;
}

//筛选符合条件的键值对
- (NSDictionary *)yk_filterDictionaryUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind {
    if (findBlock) {
        __block NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (findBlock (obj, key)) {
                [dict setObject:obj forKey:key];
                *stop = stopWhenFind;
            }
        }];
        return [dict copy];
    }
    
    return self;
}

//删除符合条件的元素
- (NSDictionary *)yk_deleteDictionaryUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *keys = [NSMutableArray array];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:self];
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (deleteBlock(obj,key)) {
                [keys addObject:key];
                *stop = stopWhenDelete;
            }
        }];
        [dict removeObjectsForKeys:keys];
        return [dict copy];
    }
    
    return self;
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level
{
    // 定义用于拼接字符串的容器
    NSMutableString *stringM = [NSMutableString string];
    
    // 拼接开头
    [stringM appendString:@"{\n"];
    
    // 遍历字典,拼接内容
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [stringM appendFormat:@"\t%@ = %@;\n",key,obj];
    }];
    
    // 拼接结尾
    [stringM appendString:@"}\n"];
    
    return stringM;
}
@end
