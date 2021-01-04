//
//  NSObject+IECExtention.m
//  IEnjoyCar
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import "NSObject+IECExtention.h"



@implementation NSObject (IECExtention)
- (NSNumber *)asNSNumber
{
    if ( [self isKindOfClass:[NSNumber class]] )
    {
        return (NSNumber *)self;
    }
    else if ( [self isKindOfClass:[NSString class]] )
    {
        return [NSNumber numberWithLongLong:[(NSString *)self longLongValue]];
    }
    else if ( [self isKindOfClass:[NSDate class]] )
    {
        return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
    }
    else if ( [self isKindOfClass:[NSNull class]] )
    {
        return [NSNumber numberWithInteger:0];
    }

    return nil;
}

- (NSString *)asNSString
{
    if ( [self isKindOfClass:[NSNull class]] )
        return nil;

    if ( [self isKindOfClass:[NSString class]] )
    {
        return (NSString *)self;
    }
    else if ( [self isKindOfClass:[NSData class]] )
    {
        NSData * data = (NSData *)self;
        return [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
    }
    else
    {
        return [NSString stringWithFormat:@"%@", self];
    }
}

- (NSDate *)asNSDate
{
    if ( [self isKindOfClass:[NSDate class]] )
    {
        return (NSDate *)self;
    }
    else if ( [self isKindOfClass:[NSString class]] )
    {
        NSDate * date = nil;
                
        if ( nil == date )
        {
            NSString * format = @"yyyy-MM-dd HH:mm:ss z";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

            date = [formatter dateFromString:(NSString *)self];
        }

        if ( nil == date )
        {
            NSString * format = @"yyyy/MM/dd HH:mm:ss z";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if ( nil == date )
        {
            NSString * format = @"yyyy-MM-dd HH:mm:ss";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }

        if ( nil == date )
        {
            NSString * format = @"yyyy/MM/dd HH:mm:ss";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }

        return date;

//        NSTimeZone * local = [NSTimeZone localTimeZone];
//        return [NSDate dateWithTimeInterval:(3600 + [local secondsFromGMT])
//                                  sinceDate:[dateFormatter dateFromString:text]];
    }
    else
    {
        return [NSDate dateWithTimeIntervalSince1970:[self asNSNumber].doubleValue];
    }
    
    return nil;
}

- (NSData *)asNSData
{
    if ( [self isKindOfClass:[NSString class]] )
    {
        return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    }
    else if ( [self isKindOfClass:[NSData class]] )
    {
        return (NSData *)self;
    }

    return nil;
}

- (NSArray *)asNSArray
{
    if ( [self isKindOfClass:[NSArray class]] )
    {
        return (NSArray *)self;
    }
    else
    {
        return [NSArray arrayWithObject:self];
    }
}

- (NSArray *)asNSArrayWithClass:(Class)clazz
{
//    if ( [self isKindOfClass:[NSArray class]] )
//    {
//        NSMutableArray * results = [NSMutableArray array];
//
//        for ( NSObject * elem in (NSArray *)self )
//        {
//            if ( [elem isKindOfClass:[NSDictionary class]] )
//            {
//                NSObject * obj = [[self class] objectFromDictionary:elem];
//                [results addObject:obj];
//            }
//        }
//
//        return results;
//    }

    return nil;
}

- (NSMutableArray *)asNSMutableArray
{
    if ( [self isKindOfClass:[NSMutableArray class]] )
    {
        return (NSMutableArray *)self;
    }
    
    return nil;
}

- (NSMutableArray *)asNSMutableArrayWithClass:(Class)clazz
{
    NSArray * array = [self asNSArrayWithClass:clazz];
    if ( nil == array )
        return nil;

    return [NSMutableArray arrayWithArray:array];
}

- (NSDictionary *)asNSDictionary
{
    if ( [self isKindOfClass:[NSDictionary class]] )
    {
        return (NSDictionary *)self;
    }

    return nil;
}

- (NSMutableDictionary *)asNSMutableDictionary
{
    if ( [self isKindOfClass:[NSMutableDictionary class]] )
    {
        return (NSMutableDictionary *)self;
    }
    
    NSDictionary * dict = [self asNSDictionary];
    if ( nil == dict )
        return nil;

    return [NSMutableDictionary dictionaryWithDictionary:dict];
}
+ (NSMutableArray *)initWihtImageStr:(NSString *)imageStr separatedStr:(NSString *)separatedStr{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i< [[imageStr componentsSeparatedByString:separatedStr] count]; i++) {
        [imageArr addObject:[imageStr componentsSeparatedByString:separatedStr][i]];
    }
    return imageArr;
}
+(NSMutableAttributedString *)bigString:(NSString *)bigString color1:(UIColor *)color1 font1:(UIFont *)font1 littleString:(NSString *)littleString color2:(UIColor *)color2 font2:(UIFont *)font2{
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setAlignment:NSTextAlignmentCenter];
    NSDictionary *adict = @{
                               NSFontAttributeName:font1,
                               NSParagraphStyleAttributeName:ps,
                               NSForegroundColorAttributeName:color1,
                               };
    NSDictionary *adict1 = @{
                                NSFontAttributeName:font2,
                                NSForegroundColorAttributeName:color2,
                                NSParagraphStyleAttributeName:ps,
                                };
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:littleString attributes:adict1];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:bigString attributes:adict];
    [string2 appendAttributedString:string1];
    return string2;
}
+(NSMutableAttributedString *)littleString:(NSString *)littleString color1:(UIColor *)color1 font1:(UIFont *)font1 bigString:(NSString *)bigString color2:(UIColor *)color2 font2:(UIFont *)font2{
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setAlignment:NSTextAlignmentLeft];
    NSDictionary *adict = @{
                               NSFontAttributeName:font1,
                               NSParagraphStyleAttributeName:ps,
                               NSForegroundColorAttributeName:color1,
                               };
    NSDictionary *adict1 = @{
                                NSFontAttributeName:font2,
                                NSForegroundColorAttributeName:color2,
                                NSParagraphStyleAttributeName:ps,
                                };
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:littleString attributes:adict];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:bigString attributes:adict1];
    [string1 appendAttributedString:string2];
    return string1;
}
@end
