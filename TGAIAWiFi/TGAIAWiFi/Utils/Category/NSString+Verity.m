//
//  NSString+Verity.m
//  uxiang
//
//  Created by Qiao on 15/11/16.
//  Copyright © 2015年 BTB Wireless Inc. All rights reserved.
//

#import "NSString+Verity.h"

@implementation NSString (Verity)

+ (BOOL) validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (BOOL)validateMobile {
//    NSString *MOBILE = @"^1[34578]\\d{9}$";
    NSString *MOBILE = @"^(1([3,8,5,9]\\d{9}|(4[5-9]|6[1,2,4,5,6,7]|7[0-8])\\d{8})|9[2,8]\\d{9})$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:self]) {
        return YES;
    }else {
        return NO;
    }
}
+ (BOOL) validateCarNo:(NSString *)carNo {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    DLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
+ (BOOL) validateCarType:(NSString *)CarType {
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}
+ (BOOL) validateUserName:(NSString *)name {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,12}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
+ (BOOL) validatePassword:(NSString *)passWord {
    NSString *passWordRegex = @"^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
+ (BOOL) validateNickname:(NSString *)nickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
+ (BOOL) validateIdentityCard: (NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
+ (BOOL) validateIdCard:(NSString *)identityString{
    if (identityString.length != 18) return NO; // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *// //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0; for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) { if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
        return NO;
    }
    } else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)effectivePassword {
    //    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"&\"< >\\/*/null & /* /NULL"];
    //    NSString *trimmedString = [self stringByTrimmingCharactersInSet:set];
    //    return trimmedString;
    NSString *regex = @"[a-zA-Z0-9]{6,20}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}
+ (NSString *)formatNumberDecimalValue:(NSString *)value {

    NSString * string = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithLongLong:value.doubleValue]
                                                         numberStyle:NSNumberFormatterDecimalStyle];
    return string;
}
+ (NSString *)changeDateFormate:(NSString *)dateString{
    NSDate *date = [NSDate dateWithString:dateString format:KDateFormatter02];
    return [NSDate br_getDateString:date format:KDateFormatter02_1];
}
- (NSString *)toDateFormatter021{
    NSDate *date = [NSDate dateWithString:self format:KDateFormatter02];
    return [NSDate br_getDateString:date format:KDateFormatter02_1];
}
- (NSString *)formatter051toDateFormatter021{
    NSDate *date = [NSDate dateWithString:self format:KDateFormatter05_1];
    return [NSDate br_getDateString:date format:KDateFormatter02_1];
}
@end
