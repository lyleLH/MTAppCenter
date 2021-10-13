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

#import "NSObject+YKExtension.h"
#import <objc/runtime.h>

@implementation YKSelector

- (void)perform:(id)obj id:(NSString *)identifier {
    if ([self.target respondsToSelector:self.action]) {
        IMP p = [self.target methodForSelector:self.action];
        if (obj) {
            void (*method)(id,SEL,NSString *,id) = (void *)p;
            method(self.target,self.action,identifier,obj);
        }else {
            void (*method)(id,SEL,NSString *) = (void *)p;
            method(self.target,self.action,identifier);
        }
    }
}

@end


@implementation NSObject (YKExtension)

- (void)yk_addTarget:(id)target sel:(SEL)sel identifier:(NSString *)identifer {
    if (!target || !sel) return;
    YKSelector *s = [YKSelector new];
    s.target = target;
    s.action = sel;
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(identifer), s, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yk_addTarget:(id)target sel:(SEL)sel {
    [self yk_addTarget:target sel:sel identifier:NSStringFromSelector(sel)];
}

- (YKSelector *)yk_target:(NSString *)identifier {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(identifier));
}

- (void)yk_callSel:(NSString *)identifier obj:(id)obj {
    YKSelector *s = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(identifier));
    [s perform:obj id:identifier];
}

- (void)yk_removeTarget:(NSString *)identifier {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(identifier), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 函数的同步异步执行
//MARK:-
////////////////////////////////////////////////////////////////


- (void)yk_performAsyncBlockInBackground:(void (^)(void))pBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), pBlock);
}
- (void)yk_performSyncBlockInBackground:(void (^)(void))pBlock {
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), pBlock);
}
- (void)yk_performAsyncBlockOnMainThread:(void (^)(void))pBlock {
    dispatch_async(dispatch_get_main_queue(), pBlock);
}
- (void)yk_performSyncBlockOnMainThread:(void (^)(void))pBlock {
    dispatch_sync(dispatch_get_main_queue(), pBlock);
}


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 归档和解档
//MARK:-
////////////////////////////////////////////////////////////////


///归档 必须在对象中实现 <-initWithCoder:>中手动调用此方法
- (void)yk_encodeObjectWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);

    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //kvc取出属性值，归档
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}

//解档
- (void)yk_decodeObjectCoder:(NSCoder *)aDecoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //kvc取出属性值，解档
        id value = [aDecoder decodeObjectForKey:key];
        //设置到成员变量身上
        [self setValue:value forKey:key];
    }
    free(ivars);
}
@end
