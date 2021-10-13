///**
/**
MTPlayground
Created by: Tom.Liu on 2021/1/14
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

#import "UIControl+YKExtension.h"
#import <objc/runtime.h>




@implementation UIControl (YKExtension)

@end


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: UIControl 分类 -  YKCheckboxEnablePrivate
//MARK:-
////////////////////////////////////////////////////////////////


@interface UIControl (YKCheckboxEnablePrivate)
@property (nonatomic,assign) BOOL yk_isSetHighlighted;
@end

@implementation UIControl (YKCheckboxEnablePrivate)
- (BOOL)yk_isSetHighlighted {
    return ((NSNumber *)objc_getAssociatedObject(self, _cmd)).boolValue;
}
- (void)setYk_isSetHighlighted:(BOOL)isSetHighlighted {
    objc_setAssociatedObject(self, @selector(yk_isSetHighlighted), @(isSetHighlighted), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end



////////////////////////////////////////////////////////////////
//MARK:-
//MARK: YKCheckboxEnable 协议 -  YKCheckboxEnableProtocol
//MARK:-
////////////////////////////////////////////////////////////////


@protocol YKCheckboxEnableProtocol <NSObject>
@required
- (void)checkboxEnableWillSetControlToNormal:(UIControl *)control;
- (void)checkboxEnableWillSetControlToHighlight:(UIControl *)control;

@optional
/**
  如果实现了该方法，在调用样式修改方法之前会调用该方法
  你必须调用 control 的 yk_didTouchHandleComplete
  否则将不会继续调用样式修改，并且所有其他按钮的按都会被阻断
 */
- (void)checkboxEnableDidTouchAControlBeforeChangingStyle:(UIControl *)control;
@end


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: UIControl 分类 -  CheckboxEnable
//MARK:-
////////////////////////////////////////////////////////////////

@interface UIControl (CheckboxEnable)
+ (void)yk_combine:(NSArray <UIControl *> *)controls withDelegate:(id<YKCheckboxEnableProtocol>)delegate;
- (void)yk_setAllCheckboxNormal;
// 调用该方法，完成对 syt_checkboxEnableDidTouchAControlBeforeChangingStyle 的处理，success 为 YES 会让样式变化成功进行，否则保持不变
- (void)yk_didTouchHandleComplete:(BOOL)success;
- (UIControl *)highlightedControl;
@end


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: YKCheckboxEnable 类定义
//MARK:-
////////////////////////////////////////////////////////////////


@interface YKCheckboxEnable : NSObject

@property (nonatomic,weak) id<YKCheckboxEnableProtocol> delegate;
@property (nonatomic,strong) NSHashTable *controls;
@property (nonatomic,assign) BOOL didTouchAControlHanling;

- (instancetype)initWithDelegate:(id)delegate;
- (void)addControl:(UIControl *)control;
- (void)setAllControlNormal;

@end



@implementation YKCheckboxEnable
- (instancetype)initWithDelegate:(id<YKCheckboxEnableProtocol>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        self.controls = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addControl:(UIControl *)control {
    [self.controls addObject:control];
    [control addTarget:self action:@selector(controlDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(control, _cmd, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)controlDidTouchUpInside:(UIControl *)control {
    if (self.didTouchAControlHanling) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(checkboxEnableDidTouchAControlBeforeChangingStyle:)]) {
        self.didTouchAControlHanling = YES;
        [self.delegate checkboxEnableDidTouchAControlBeforeChangingStyle:control];
    }else {
        [self updateStyleWithControl:control];
    }
}

- (void)updateStyleWithControl:(UIControl *)control {
    NSEnumerator<UIControl *> *enumrator = self.controls.objectEnumerator;
    UIControl *con;
    while ((con = enumrator.nextObject)) {
        if (con != control) {
            [self.delegate checkboxEnableWillSetControlToNormal:con];
            con.yk_isSetHighlighted = NO;
        }else {
            [self.delegate checkboxEnableWillSetControlToHighlight:con];
            con.yk_isSetHighlighted = YES;
        }
    }
}

- (void)setAllControlNormal {
    NSEnumerator<UIControl *> *enumrator = self.controls.objectEnumerator;
    UIControl *con;
    while ((con = enumrator.nextObject)) {
        [self.delegate checkboxEnableWillSetControlToNormal:con];
    }
}



@end


