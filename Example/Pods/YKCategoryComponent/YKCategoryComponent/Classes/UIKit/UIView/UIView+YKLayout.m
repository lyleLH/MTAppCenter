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

#import "UIView+YKLayout.h"

@implementation UIView (YKLayout)
 
- (CGPoint)yk_origin {
    return self.frame.origin;
}

- (void)setYk_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)yk_size {
    return self.frame.size;
}

- (void)setYk_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


// Query other frame locations
- (CGPoint) yk_bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) yk_bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) yk_topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}



- (CGFloat)yk_left {
    return self.frame.origin.x;
}

- (void)setYk_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)yk_top {
    return self.frame.origin.y;
}

- (void)setYk_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)yk_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYk_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)yk_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYk_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)yk_width {
    return self.frame.size.width;
}

- (void)setYk_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)yk_height {
    return self.frame.size.height;
}

- (void)setYk_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)yk_centerX {
    return self.center.x;
}

- (void)setYk_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)yk_centerY {
    return self.center.y;
}

- (void)setYk_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


@end
