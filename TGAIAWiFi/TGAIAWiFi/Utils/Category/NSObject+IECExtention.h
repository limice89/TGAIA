//
//  NSObject+IECExtention.h
//  IEnjoyCar
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (IECExtention)
- (NSNumber *)asNSNumber;
- (NSString *)asNSString;
- (NSDate *)asNSDate;
- (NSData *)asNSData;    // TODO
- (NSArray *)asNSArray;
- (NSArray *)asNSArrayWithClass:(Class)clazz;
- (NSMutableArray *)asNSMutableArray;
- (NSMutableArray *)asNSMutableArrayWithClass:(Class)clazz;
- (NSDictionary *)asNSDictionary;
- (NSMutableDictionary *)asNSMutableDictionary;

/**
 传一个字符串，解析一个图片数组
 */
+ (NSMutableArray *)initWihtImageStr:(NSString *)imageStr separatedStr:(NSString *)separatedStr;
+(NSMutableAttributedString *)bigString:(NSString *)bigString color1:(UIColor *)color1 font1:(UIFont *)font1 littleString:(NSString *)littleString color2:(UIColor *)color2 font2:(UIFont *)font2;
+(NSMutableAttributedString *)littleString:(NSString *)littleString color1:(UIColor *)color1 font1:(UIFont *)font1 bigString:(NSString *)bigString color2:(UIColor *)color2 font2:(UIFont *)font2;
@end

NS_ASSUME_NONNULL_END
