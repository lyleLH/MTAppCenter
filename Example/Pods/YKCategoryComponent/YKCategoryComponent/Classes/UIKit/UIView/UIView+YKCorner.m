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

#import "UIView+YKCorner.h"

@implementation UIView (YKCorner)
-(void)yk_cornerStyle:(YKCornerStyle)cornerStyle cornerRadius:(CGFloat) radius {
    
    UIRectCorner corners;
    
    switch (cornerStyle )
    {
        case YKCornerStyleLeftTop:
            corners = UIRectCornerTopLeft;
            break;
        case YKCornerStyleRightTop:
            corners = UIRectCornerTopRight;
            break;
        case YKCornerStyleLeftBottom:
            corners = UIRectCornerBottomLeft;
            break;
        case YKCornerStyleRightBottom:
            corners = UIRectCornerBottomRight;
            break;
        case YKCornerStyleTopAll:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case YKCornerStyleBottomAll:
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case YKCornerStyleLeftAll:
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            break;
        case YKCornerStyleRightAll:
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        case YKCornerStyleAll:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case YKCornerStyleNoLeftTop:
            corners = UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case YKCornerStyleNoRightTop:
            corners = UIRectCornerTopLeft  | UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
            
        case YKCornerStyleNoLeftBottom:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight  | UIRectCornerBottomRight;
            break;
            
        case YKCornerStyleNoRightBottom:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft ;
            break;
            
        default:
            corners = UIRectCornerAllCorners;
            break;
    }
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius*2, radius*2)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}
@end
