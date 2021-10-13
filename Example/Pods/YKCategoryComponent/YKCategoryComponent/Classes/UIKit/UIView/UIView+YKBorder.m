///**
/**
MTPlayground
Created by: Tom.Liu on 2021/1/13
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

#import "UIView+YKBorder.h"
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSUInteger, YKBorderTag) {
    YKBorderTagTop = 65532,
    YKBorderTagBottom = 65533,
    YKBorderTagLeft = 65534,
    YKBorderTagRight = 65535
};

@interface YKBorder ()
@property (nonatomic,weak) UIView *target;
@property (nonatomic,strong) UIView *border;
- (instancetype)initWithTarget:(UIView *)target;
@end

@interface YKBorderSettings ()
@property (nonatomic,assign) YKBorderTag tag;
@property (nonatomic,weak) UIView *target;
@property (nonatomic,weak) UIView *border;
@end

@implementation YKBorder
- (instancetype)initWithTarget:(UIView *)target {
    if (self = [super init]) {
        self.target = target;
    }
    return self;
}

- (YKBorderSettings *)top {
    YKBorderSettings *borderSettings = [YKBorderSettings new];
    if (![self configSettings:borderSettings flag:YKBorderTagTop]) {
        [self.border mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.target);
            make.height.mas_equalTo(1);
        }];
    }
    return borderSettings;
}
- (YKBorderSettings *)bottom {
    YKBorderSettings *borderSettings = [YKBorderSettings new];
    if (![self configSettings:borderSettings flag:YKBorderTagBottom]) {
        [self.border mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.target);
            make.height.mas_equalTo(1);
        }];
    }
    return borderSettings;
}
- (YKBorderSettings *(^)(CGFloat))bottomWith {
    return ^YKBorderSettings *(CGFloat value) {
        YKBorderSettings *borderSettings = [YKBorderSettings new];
        if (![self configSettings:borderSettings flag:YKBorderTagBottom]) {
            [self.border mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.target);
                make.bottom.equalTo(self.target).with.offset(-value);
                make.height.mas_equalTo(1);
            }];
        }
        return borderSettings;
    };
}
- (YKBorderSettings *)left {
    YKBorderSettings *borderSettings = [YKBorderSettings new];
    if (![self configSettings:borderSettings flag:YKBorderTagLeft]) {
        [self.border mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.target);
            make.width.mas_equalTo(1);
        }];
    }
    return borderSettings;
}
- (YKBorderSettings *)right {
    YKBorderSettings *borderSettings = [YKBorderSettings new];
    if (![self configSettings:borderSettings flag:YKBorderTagRight]) {
        [self.border mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.target);
            make.width.mas_equalTo(1);
        }];
    }
    return borderSettings;
}
- (BOOL)configSettings:(YKBorderSettings *)settings flag:(YKBorderTag)tag {
    BOOL exist = NO;
    for (UIView *subView in self.target.subviews) {
        if (subView.tag == tag) {
            self.border = [self.target viewWithTag:tag];
            self.border.hidden = NO;
            exist = YES;
            break;
        }
    }
    if (!exist) {
        self.border = [UIView new];
        self.border.tag = tag;
        [self.target addSubview:self.border];
    }
    settings.tag = tag;
    settings.target = self.target;
    settings.border = self.border;
    return exist;
}

@end

@implementation YKBorderSettings
- (YKBorderSettings *(^)(UIColor *))color {
    return ^YKBorderSettings * (UIColor *color) {
        self.border.backgroundColor = color;
        return self;
    };
}
- (YKBorderSettings *(^)(CGFloat))width {
    return ^YKBorderSettings * (CGFloat width) {
        [self.border mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.tag == YKBorderTagTop || self.tag == YKBorderTagBottom) {
                make.height.mas_equalTo(width);
            }else if (self.tag == YKBorderTagLeft || self.tag == YKBorderTagRight) {
                make.width.mas_equalTo(width);
            }
        }];
        return self;
    };
}
- (YKBorderSettings *(^)(CGFloat))leftEdge {
    return ^YKBorderSettings * (CGFloat value) {
        [self.border mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.tag == YKBorderTagTop || self.tag == YKBorderTagBottom) {
                make.left.equalTo(self.target).with.offset(value);
            }else if (self.tag == YKBorderTagLeft || self.tag == YKBorderTagRight) {
                make.top.equalTo(self.target).with.offset(value);
            }
        }];
        return self;
    };
}
- (YKBorderSettings *(^)(CGFloat))rightEdge {
    return ^YKBorderSettings * (CGFloat value) {
        [self.border mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.tag == YKBorderTagTop || self.tag == YKBorderTagBottom) {
                make.right.equalTo(self.target).with.offset(-value);
            }else if (self.tag == YKBorderTagLeft || self.tag == YKBorderTagRight) {
                make.bottom.equalTo(self.target).with.offset(-value);
            }
        }];
        return self;
    };
}
- (void (^)(BOOL))hide {
    return ^void (BOOL value) {
        self.border.hidden = value;
    };
}
- (void (^)(void))remove {
    return ^void (void) {
        [self.border removeFromSuperview];
    };
}
@end

 
@implementation UIView (YKBorder)
- (YKBorder *)ykBorder {
    YKBorder *border = [[YKBorder alloc] initWithTarget:self];
    return border;
}

@end
