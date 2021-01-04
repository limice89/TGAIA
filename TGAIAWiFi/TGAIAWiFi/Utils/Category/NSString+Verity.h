//
//  NSString+Verity.h
//  uxiang
//
//  Created by Qiao on 15/11/16.
//  Copyright © 2015年 BTB Wireless Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verity)
/**
 *  邮箱
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 *  手机号
 */
- (BOOL)validateMobile;
/**
 *  车牌号
 */
+ (BOOL) validateCarNo:(NSString *)carNo;
/**
 *  车系
 */
+ (BOOL) validateCarType:(NSString *)CarType;
/**
 *  用户名
 */
+ (BOOL) validateUserName:(NSString *)name;
/**
 *  密码
 */
+ (BOOL) validatePassword:(NSString *)passWord;
/**
 *  昵称
 */
+ (BOOL) validateNickname:(NSString *)nickname;
/**
 *  身份证
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL) validateIdCard:(NSString *)identityString;

/**
 *  判断是否有特殊字符
 */
- (BOOL)effectivePassword;
/**
 *  中文
 */
-(BOOL)isChinese;

+ (BOOL)checkPassword:(NSString *) password;
//字符转化为 111111 = 111,111
+ (NSString *)formatNumberDecimalValue:(NSString *)value;
//时间格式 KDateFormatter02 -> KDateFormatter02_1
+ (NSString *)changeDateFormate:(NSString *)dateString;
- (NSString *)toDateFormatter021;
- (NSString *)formatter051toDateFormatter021;
@end
