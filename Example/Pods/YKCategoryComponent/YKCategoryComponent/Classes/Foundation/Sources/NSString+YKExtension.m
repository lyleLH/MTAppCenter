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

#import "NSString+YKExtension.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
//IP地址
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
//手机型号
#import <sys/sysctl.h>
#import <sys/utsname.h>
//广告标识
#import <AdSupport/AdSupport.h>
//Base64
#import "NSData+YKExtension.h"


@implementation NSString (YKExtension)


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 字符串基本处理
//MARK:-
////////////////////////////////////////////////////////////////



/// 是否为合法的字符串  string!=nil && string!=NSNull && string.length>0
/// @param string 入参 字符串
+ (BOOL)yk_isValidateString:(NSString *)string {
    BOOL success = YES;
    if (!string || [string isKindOfClass:[NSNull class]] || string.length <= 0) {
        success = NO;
    }
    return success;
}



+ (NSString *(^)(NSString*ary))yk_s{
    return ^(NSString *string){
        return [NSString stringWithFormat:@"%@",string];
    };
}

+ (NSString *(^)(NSArray<NSString*>*ary))yk_bonding {
    return ^(NSArray<NSString*>*ary) {
        __block NSString * string = [NSString new];
        [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            string = [string stringByAppendingString:obj];
        }];
        return  string;
    };
}


/// 两个字符串的所有字符全部小写之后，两个字符串是否相等
/// @param string 待比较的字符串
- (BOOL)yk_isEqualWhenBothInLowercaseString:(NSString *)string
{
    NSString* selfStr = self.lowercaseString;
    NSString* otherStr = string.lowercaseString;
    if ([selfStr isEqualToString:otherStr]) {
        return YES;
    }
    return NO;
}


/// 是否含有某字符串
/// @param subString 判断是否包含时传入的子串
- (BOOL)yk_containsString:(NSString*)subString
{
    if(![NSString yk_isValidateString:subString]) return NO;
    
    NSRange range = [self rangeOfString:subString];
    
    return range.location != NSNotFound;
}
 
/// 去除空格和回车,换行
- (NSString *)yk_trimSpaceString {
    if (!self) {
        return nil;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
///去除字符串的前后空格
- (NSString*)yk_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 编码解码、加密解密
//MARK:-
////////////////////////////////////////////////////////////////
///NSString转为NSData
- (NSData *)yk_data{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
///NSString转为Char
- (const char *)yk_char{
    return [self UTF8String];
}
///MD5加密
- (NSString *)yk_MD5String {
    const char* cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    //return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

///SHA1加密
- (NSString *)yk_SHA1String {
    const char* cstr = [self UTF8String];
    NSData* data = [NSData dataWithBytes:cstr length:[self length]];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

///UTF-8编码
- (NSString *)yk_URLEncodedString {
    NSString* result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    return result;
}



/// 指定编码方式编码
/// @param encoding 指定某种编码方式
- (NSString *)yk_URLEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

///UTF-8解码
- (NSString *)yk_URLDecodedString {
    NSString* result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return result;
}

/// 指定某种格式解码
/// @param encoding 指定的某种解码格式
- (NSString *)yk_URLDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}
/// 用指定编码格式将NSData解码成字符串
+ (NSString *)yk_stringWithData:(NSData *)pData encoding:(NSStringEncoding)pEncoding {
    return [[NSString alloc] initWithData:pData encoding:pEncoding];
}

/// NSString base64编码成NSData
- (NSData *)yk_base64EncodedData {
    return [[self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO] yk_base64EncodedData];
}
/// NSString base64编码成NSString
- (NSString *)yk_base64Encoded {
    return [[self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO] yk_base64Encoded];
}
/// NSString base64解码成NSData
- (NSData *)yk_base64DecodedData {
    return [[self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO] yk_base64DecodedData];
}

/// NSString base64解码成NSString
- (NSString *)yk_base64Decoded {
    return [[self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO] yk_base64Decoded];
}



////////////////////////////////////////////////////////////////
//MARK:-
//MARK:APP信息、设备信息
//MARK:-
////////////////////////////////////////////////////////////////


///获取App的版本号字符串 1.23.45
+ (NSString*)yk_appVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
    
}

/// 获取App的build号
+ (NSString*)yk_appBuildVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appBuildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return appBuildVersion;
}

+ (NSString*)yk_appBundleId {
    return [[NSBundle mainBundle]bundleIdentifier];
}

+ (NSString*)yk_appName {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return appName;
}


///把3段 6位的版本号 转换为6为数字字符串 (1.23.4 --> 102304)
///@param versions App的版本号字符串
+ (NSString *)yk_versionStrtingToNumberString:(NSString*)versions {
    NSArray <NSString *>*arry=[versions componentsSeparatedByString:@"."];
    NSMutableArray * numberAry = [[NSMutableArray alloc] initWithCapacity:6];
    //    for (NSString *i in arry){
    //        NSLog(@"%@",i);
    //    }
    for (NSInteger i =0; i <arry.count; i ++) {
        
        if(arry[i].length==1){
            
            if(i==2){
                [numberAry insertObject:@"0" atIndex:2*i];
                [numberAry insertObject:arry[i] atIndex:2*i+1];
            }else{
                [numberAry insertObject:arry[i] atIndex:2*i];
                [numberAry insertObject:@"0" atIndex:2*i+1];
            }
        }else if(arry[i].length==2){
            if(i==2){
                NSMutableArray *letterArray = [NSMutableArray array];
                
                [arry[i] enumerateSubstringsInRange:NSMakeRange(0, [arry[i]  length])
                                            options:(NSStringEnumerationByComposedCharacterSequences)
                                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                    [letterArray addObject:substring];
                }];
                
                [numberAry insertObject:letterArray[1] atIndex:2*i];
                [numberAry insertObject:letterArray[0] atIndex:2*i+1];
            }else{
                NSMutableArray *letterArray = [NSMutableArray array];
                
                [arry[i] enumerateSubstringsInRange:NSMakeRange(0, [arry[i]  length])
                                            options:(NSStringEnumerationByComposedCharacterSequences)
                                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                    [letterArray addObject:substring];
                }];
                
                [numberAry insertObject:letterArray[0] atIndex:2*i];
                [numberAry insertObject:letterArray[1] atIndex:2*i+1];
            }
            
        }
    }
    //    NSLog(@"------------------");
    //    for (NSString *i in numberAry){
    //        NSLog(@"%@",i);
    //    }
    NSMutableString * result = [[NSMutableString alloc] init];
    for (NSObject * obj in numberAry)
    {
        [result appendString:[obj description]];
    }
    NSLog(@"%@",result);
    return  result;
}

// 获取设备IP地址
+ (NSString *)yk_getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // 检索当前接口,在成功时,返回0
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 循环链表的接口
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // 检查接口是否en0 wifi连接在iPhone上
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 得到NSString从C字符串
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // 释放内存
    freeifaddrs(interfaces);
    return address;
}


///设备版本号
+ (NSString *)yk_deviceVersion {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}


///设备唯一标识符 ，注意idfa的采集是否合法。
+ (NSString *)yk_UUID {
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if (idfa) {
            return idfa;
        } else {
            NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            return idfv;
        }
    } else {
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        return idfv;
    }
}

////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 常用的 输入-字符串 验证
//MARK:-
////////////////////////////////////////////////////////////////



/// 是否为合法的email地址
- (BOOL)yk_isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/// 是否是中文字符串 实例方法
- (BOOL)yk_isChineseString {
    return [[self class] yk_isChineseString:self];
    
    
}


+ (BOOL)yk_isChineseString:(NSString *)string {
    BOOL isChinese = YES;
    if (![[self class] yk_isValidateString:string]) {
        return NO;
    }
    
    for (NSInteger i = 0; i < string.length; i++) {
        unichar chineseChar = [string characterAtIndex:i];
        if (!(chineseChar >= 0x4E00 && chineseChar <= 0x9FFF)) {
            isChinese = NO;
        }
    }
    
    return isChinese;
}





/// 字符串中是否含有中文字符串 静态方法
/// @param text  传入字符串
+ (BOOL)yk_isContainsChineseChar:(NSString *)text {
    for (int i=0; i<text.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [text substringWithRange:range];
        const char    *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            return YES;
        }
    }
    return NO;
}

/// /// 是否仅由中文、大小写字母、数字、下划线组成
- (BOOL)yk_isChineseLetterDigitalOrUnderline {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5_a-zA-Z0-9]+$"];
    return [predicate evaluateWithObject:self];
}

/// /// 是否仅由中文、大小写字母、数字组成
- (BOOL)yk_isChineseLetterDigital {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5a-zA-Z0-9]+$"];
    return [predicate evaluateWithObject:self];
}


/// 阿拉伯数字 转成中文数字（一二三四等等）
/// @param value 阿拉伯数字
+ (NSString *)yk_integerToChineseNumber:(NSInteger)value {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
    formatter.locale = locale;
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    return [formatter stringFromNumber:[NSNumber numberWithInt:(int)value]];
}


/// 十进制数字包括：0 1 2 3 4 5 6 7 8 9。一般用于判断单个字符     123456789 YES |  123456.789 NO | -123456789 NO

- (BOOL)y_isPureDecial {
    NSString *regex = @"^(\\-|\\+)?\\d+(\\.\\d+)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

///是否是数字串
- (BOOL)yk_isPureNumber {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

///是否是数字串
- (BOOL)yk_isPureInteger {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scanner scanInteger:&val] && [scanner isAtEnd];
}

///是否是小数串
- (BOOL)yk_isPureDouble {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    double val;
    return [scanner scanDouble:&val] && [scanner isAtEnd];
}

/// 纯小数 串
- (BOOL)yk_isPureDecimal {
    NSString *regex = @"^(\\-|\\+)?\\d+(\\.\\d+)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
/// 是否是有效的手机号
/// @param mobile 传入待验证的手机号
+ (BOOL)yk_isValidateMobile:(NSString *)mobile {
    if (![self yk_isValidateString:mobile]) {
        return NO;
    }
    NSString *phoneRegex = @"^(1[0-9])\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/// 是否是有效的手机号
- (BOOL)yk_isValidateMobile {
    return [[self class] yk_isValidateMobile:self];
}


/// 是否仅由数字组成
- (BOOL)yk_isOnlyDigit {
    if (![NSString yk_isValidateString:self]) {
        return NO;
    }
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


/// 是否仅由大小写字母组成
- (BOOL)yk_isOnlyLetter {
    if (![NSString yk_isValidateString:self]) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/// 是否仅由重复数字组成
- (BOOL)yk_isDuplicateDigit {
    if (self.length > 0) {
        unichar c = [self characterAtIndex:0];
        for (int i = 1; i < self.length; i++) {
            unichar curC = [self characterAtIndex:i];
            if (curC != c) return NO;
        }
        return YES;
    }
    return NO;
}

/// 是否仅由连续数字组成
- (BOOL)yk_isContinuousDigit {
    NSString *c = [self substringToIndex:1];
    for (int i = 1; i < self.length; i++) {
        NSString *curC = [self substringWithRange:NSMakeRange(i, 1)];
        if (curC.integerValue != c.integerValue + 1 && curC.integerValue != c.integerValue - 1) return NO;
        c = curC;
    }
    return YES;
}


/// 是否仅由数字、大小写字母组成
/// @param string 传入待验证的字符串
+ (BOOL)yk_isOnlyDigitLetter:(NSString *)string {
    if (![self yk_isValidateString:string]) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z0-9]{1,300}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}
/// 是否仅由纯数字、纯字母或包含数字、大小写字母组成
/// @param string 传入待验证的字符串
+ (BOOL)yk_isOnlyAndContainDigitLetter:(NSString *)string {
    if (![self yk_isValidateString:string]) {
        return NO;
    }
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/// 是否仅由数字、大小写字母
- (BOOL)yk_isOnlyDigitLetter {
    return [[self class] yk_isOnlyDigitLetter:self];
}

/// 是否仅由数字、大小写字母、下划线组成
/// @param string 传入待验证的字符串
+ (BOOL)yk_isOnlyDigitLetterUnderline:(NSString *)string {
    if (![self yk_isValidateString:string]) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z0-9_]{1,300}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/// 是否仅由数字、大小写字母、下划线组成
- (BOOL)yk_isOnlyDigitLetterUnderline
{
    return [[self class] yk_isOnlyDigitLetterUnderline:self];
}


/// 是否由 min-max位的大小写字母和数字组合构成
/// @param min 最小位数
/// @param max 最大位数
- (BOOL)yk_isNumAndLetterCombWithMin:(int)min toMax:(int)max {
    NSString *pattern = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{%d,%d}",min,max];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:self];
}



/// 是整数或者小数
- (BOOL)yk_isIntOrPoint {
    NSString *regex = @"^[0-9|.]{0,100}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/*!
 * 是否为正整数，成功返回整数数值，失败返回-1
 */
- (NSInteger)yk_isPositiveInteger {
    NSScanner* scan = [NSScanner scannerWithString:self];
    NSInteger val = -1;
    BOOL success = [scan scanInteger:&val] && [scan isAtEnd];
    NSLog(@"isPositiveInteger = %d", (int)val);
    if (!success) {
        return -1;
    }
    return val;
}
/*!
 * 是否为正浮点型数,成功返回浮点数值，失败返回-1
 */
- (float)yk_isPositiveFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val = -1;
    BOOL success = [scan scanFloat:&val] && [scan isAtEnd];
    NSLog(@"isPureFloat = %f", val);
    if (!success) {
        return -1;
    }
    return val;
}

/// 是否符合密码规则,6-20位长度
/// @param passWord 传入待验证的密码
+ (BOOL)yk_isValidatePwd:(NSString *)passWord {
    return [passWord yk_isValidatePwdMin:6 toMax:20];
}





/// 验证密码位数
/// @param min 最小位数
/// @param max 最大位数
- (BOOL)yk_isValidatePwdMin:(int)min toMax:(int)max {
    NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%d,%d}+$",min,max];
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}


/// 是否符合密码规则，返回未符合的规则提示，6-20位｜必须有大、小写字母和数字｜不能含有中文｜不能含有非法字符
- (NSString *)yk_checkPaswordInvalidation {
    BOOL hasNumber = NO,hasUpperCase = NO,hasLowerCase = NO;;
    if (self.length < 6)  return @"密码小于6位";
    if (self.length > 20) return @"密码大于20位";
    for (int i = 0; i < self.length; i++) {
        
        NSString *singleString = [self substringWithRange:NSMakeRange(i,1)];
        if (strlen([singleString UTF8String]) == 3) return @"密码含有中文";
        
        char singleChar = [self characterAtIndex:i];
        if (singleChar > 64 && singleChar < 91) hasUpperCase = YES;
        else if (singleChar > 96 && singleChar < 123) hasLowerCase = YES;
        else if (singleChar > 47 && singleChar < 58) hasNumber = YES;
        else return @"密码含有非法字符";
    }
    if (!hasNumber) return @"密码缺少数字";
    if (!hasUpperCase) return @"密码缺少大写字母";
    if (!hasLowerCase) return @"密码缺少小写字母";
    return nil;
}

/// 是否符合身份证姓名规则 ，返回未符合的规则提示，姓名2-20位｜姓名需为汉字或字母
- (NSString *)yk_checkIdCardNameValid {
    if (self.length < 2)  return @"身份证姓名小于2位";
    if (self.length > 20) return @"身份证姓名大于20位";
    for (int i = 0; i < self.length; i++) {
        NSString *singleString = [self substringWithRange:NSMakeRange(i,1)];
        if ([singleString isEqualToString:@"·"]) {
            continue;
        }
        const char *cString = [singleString UTF8String];
        if (cString == NULL) {
            return @"姓名需为汉字或字母";
        }
        if (strlen(cString) != 3) {
            char singleChar = [self characterAtIndex:i];
            if (!(singleChar > 64 && singleChar < 91) && !(singleChar > 96 && singleChar < 123)) {
                return @"姓名需为汉字或字母";
            }
        }
    }
    return nil;
}


/// 修正浮点型精度丢失
/// @param str 传入接口取到的数据
+ (NSString *)yk_reviseFloatingPointStringAccuracyWith:(NSString *)str {
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


/// 字符串是否包含表情字符
/// @param string 传入字符串
+ (BOOL)yk_isStringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 货币转换
//MARK:-
////////////////////////////////////////////////////////////////


///  数字转换成货币数字字符串 结果到小数点后2位，例如15.05,如果是0则显示为0 TODO:测试
- (NSString*)yk_changeYuan {
    
    long amount = [self longLongValue];
    if (amount <= 0) {
        amount = 0;
    }
    long amountInt = amount/100;
    long amountDecimal = amount%100;
    return [NSString stringWithFormat:@"%ld.%02ld",amountInt,amountDecimal];
}

/// TODO:测试
- (NSString*)yk_changeYuanWithSymbol {
    long amount = [self longLongValue];
    long amountInt = amount/100;
    long amountDecimal = amount%100;
    return [NSString stringWithFormat:@"%ld.%02ld",amountInt,labs(amountDecimal)];
}

- (NSString*)yk_changeCent {
    
    int amount = [self intValue];
    if (amount <= 0) {
        amount = 0;
    }
    int amountInt = amount/1000000;
    int amountDecimal = amount%1000000;
    return [NSString stringWithFormat:@"%d.%02d",amountInt,amountDecimal];
}

- (NSString*)yk_changeTenthousand {
    
    int amount = [self intValue];
    if (amount <= 0) {
        amount = 0;
    }
    int amountInt = amount/10000;
    int amountDecimal = amount%10000;
    return [NSString stringWithFormat:@"%d.%02d",amountInt,amountDecimal];
}

///转换成百分比
- (NSString *)yk_changeToRate {
    CGFloat f = [self floatValue];
    int rate = (int)roundf((f*10));
    return [NSString stringWithFormat:@"%@",@(rate)];
}

//转换成浮点数 TODO:测试
-(NSString *)yk_changeFloat {
    NSString *stringFloat = self;
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--) {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}



////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 富文本
//MARK:-
////////////////////////////////////////////////////////////////


/// 为字符串的子串添加富文本属性
/// @param dict 富文本属性字典
/// @param string 子串
- (NSAttributedString *)yk_addAttributes:(NSDictionary<NSAttributedStringKey,id> *)dict inString:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (!dict || ![NSString yk_isValidateString:string]) {
        return attributedString;
    }
    NSRange range = [self rangeOfString:string];
    if (range.location != NSNotFound) {
        [attributedString addAttributes:dict range:range];
    }
    return attributedString;
}

///  将母串中含有的子串单独设定某个颜色，返回设置后的富文本字符串
/// @param string 母串
/// @param color 子串要设定的颜色
/// @param rangeString 子串
+ (NSMutableAttributedString *)yk_attributedString:(NSString *)string Color:(UIColor *)color rangeString:(NSString *)rangeString{
    NSRange range = [string rangeOfString:rangeString];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attStr;
}

/// 将母串（自身）中含有的子串单独设定某个字体、字色，返回设置后的富文本字符串
/// @param str 子串
/// @param color 子串要设定的字体颜色
/// @param font 子串要设定的字体
- (NSMutableAttributedString *)yk_attributedStringWithStr:(NSString *)str color:(UIColor *)color font:(UIFont *)font {
    
    NSRange range = [self rangeOfString:str];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attStr addAttribute:NSFontAttributeName value:font range:range];
    return attStr;
}


/// 将母串（自身）中含有的子串单独设定某个字体，返回设置后的富文本字符串
/// @param font 子串要设定的字体
/// @param rangeString 子串
- (NSMutableAttributedString *)yk_attributedStringWithFont:(UIFont *)font rangeString:(NSString *)rangeString {
    NSRange range = [self rangeOfString:rangeString];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attStr addAttribute:NSFontAttributeName value:font range:range];
    return attStr;
}




////////////////////////////////////////////////////////////////
//MARK:-
//MARK:信息脱敏相关的
//MARK:-
////////////////////////////////////////////////////////////////


/// 银行卡账号脱敏 16位以上 只显示前6位和后4位明文｜8-16位 只显示前2位和后2位明文｜1-8位 只显示最后1位明文
- (NSString *)yk_bankAccountDesensitizationString {
    if (self.length >= 16) {
        return [NSString stringWithFormat:@"%@******%@",[self substringToIndex:6],[self substringFromIndex:self.length - 4]];
    }else if (self.length < 16 && self.length >= 8) {
        return [NSString stringWithFormat:@"%@****%@",[self substringToIndex:2],[self substringFromIndex:self.length - 2]];
    }else if (self.length < 8 && self.length > 1) {
        return [NSString stringWithFormat:@"*%@",[self substringFromIndex:self.length - 1]];
    }else {
        return self;
    }
}

/// 银行卡账户名脱敏 ，只显示名字，不显示姓（姓的第一位隐藏）
- (NSString *)yk_bankAccountNameDesensitizationString {
    return self.length > 1 ? [NSString stringWithFormat:@"*%@",[self substringFromIndex:1]] : self;
}

/// 手机号脱敏 只显示前3位和后4位
- (NSString *)yk_phoneNumberDesensitizationString {
    return self.length > 7 ? [NSString stringWithFormat:@"%@*****%@",[self substringToIndex:3],[self substringFromIndex:self.length - 4]] : self;
}

// TODO:待确认
- (NSString *)yk_seatNumberDesensitizationString {
    if (self.length <= 10 && self.length > 3) {
        return [NSString stringWithFormat:@"%@***%@",[self substringToIndex:1],[self substringFromIndex:self.length - 2]];
    }else if (self.length > 10) {
        return [NSString stringWithFormat:@"%@***%@",[self substringToIndex:6],[self substringFromIndex:self.length - 2]];
    }else {
        return self;
    }
}
/// 身份证号脱敏 只显示前6位和后4位明文
- (NSString *)yk_idCardNumberDesensitizationString {
    return self.length > 10 ? [NSString stringWithFormat:@"%@***%@",[self substringToIndex:6],[self substringFromIndex:self.length - 4]] : self;
}


///只显示前三位明文 TODO:待确认
- (NSString *)yk_formataSterisk {
    NSInteger count = self.length;
    if (count > 3) {
        NSString *name = [self substringWithRange:NSMakeRange(0, 3)];
        for (int i=0; i<count-3; i++) {
            name = [name stringByAppendingString:@"*"];
        }
        return name;
    }else{
        return self;
    }
}

/// 连号的银行卡号转换成 4位一段的字符串
+ (NSString*)yk_addSpaceBankNumber:(NSString*)strText
{
    NSMutableString* strReturn = [NSMutableString stringWithString:strText];
    [strReturn replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [strReturn length])];
    NSMutableString* lastTxt = [NSMutableString stringWithString:strReturn];
    NSInteger nLen = lastTxt.length;
    if (nLen>=4)
    {
        [lastTxt insertString:@" " atIndex:4];
        nLen = lastTxt.length;
    }
    if (nLen>=9)
    {
        [lastTxt insertString:@" " atIndex:9];
        nLen = lastTxt.length;
    }
    if (nLen>=14)
    {
        [lastTxt insertString:@" " atIndex:14];
        nLen = lastTxt.length;
    }
    if (nLen>=19)
    {
        [lastTxt insertString:@" " atIndex:19];
    }
    
    return lastTxt;
}


 

////////////////////////////////////////////////////////////////
//MARK:-
//MARK:- 字符串计算
//MARK:-
////////////////////////////////////////////////////////////////


/// 固定高度和字号 计算字符串宽度
/// @param height 给定高度
/// @param fontSize 给定字号
- (float)yk_widthByLimitHeight:(float)height fontSize:(float)fontSize
{
    return [self yk_widthByLimitHeight:height font:[UIFont systemFontOfSize:fontSize]];
}

/// 固定高度和字体 计算字符串宽度
/// @param height 给定高度
/// @param font 给定字体
- (float)yk_widthByLimitHeight:(float)height font:(UIFont *)font
{
    CGSize size = CGSizeMake(0, height);
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect frame = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    return frame.size.width;
}

/// 固定宽度和字号 计算字符串高度
/// @param width 给定宽度
/// @param fontSize 给定字号
- (float)yk_heightByLimitWidth:(float)width fontSize:(float)fontSize
{
    return [self yk_heightByLimitWidth:width font:[UIFont systemFontOfSize:fontSize]];
}

/// 固定宽度和字号 计算字符串高度
/// @param width 给定宽度
/// @param font 给定字体
- (float)yk_heightByLimitWidth:(float)width font:(UIFont *)font
{
    CGFloat height = 0;
    CGSize size = CGSizeMake(width, 0);
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect frame = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    height = frame.size.height;
    return height;
}


/// 固定宽度和字号 计算 Size
/// @param width 固定宽度
/// @param font 给定字体
- (CGSize)yk_sizeByLimitWidth:(float)width font:(UIFont *)font
{
    CGSize size = CGSizeMake(width, 0);
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect frame = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    return frame.size;
}

/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 **/
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth
          isLimitedToLines:(BOOL *)isLimitedToLines {
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        if (rows > numberOfLines) {
            rows = numberOfLines;
            if (isLimitedToLines) {
                *isLimitedToLines = YES;  //被限制
            }
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }
    
    return CGSizeMake(constrainedWidth, realHeight);
}


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: 时间 NSDate相关
//MARK:-
////////////////////////////////////////////////////////////////


/// 根据时间字符串生成时间对象
/// @param format 指定时间对象中时间的格式 <"YYYY.MM.DD"等>
- (NSDate *)yk_dateWithFormateString:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:self];
}

@end
