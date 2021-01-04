//
//  NSString+PinYin.m
//  IEnjoyCar
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import "NSString+PinYin.h"



@implementation NSString (PinYin)
//pinyin
-(NSString*)transformToPinyin{
    NSMutableString *mutableString=[NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString,NULL,kCFStringTransformToLatin,false);
    mutableString = (NSMutableString*)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
   mutableString = [[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    return mutableString.lowercaseString;
}


- (NSString *)transformToPinyinFirstLetter {
    NSMutableString *stringM = [NSMutableString string];
    
    
    NSString *temp  =  nil;
    for(int i = 0; i < [self length]; i++){
        
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        
        NSMutableString *mutableString=[NSMutableString stringWithString:temp];
        
        CFStringTransform((CFMutableStringRef)mutableString,NULL,kCFStringTransformToLatin,false);
        
        mutableString = (NSMutableString*)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        
        mutableString =  [[mutableString substringToIndex:1] mutableCopy];
        
        [stringM appendString:(NSString *)mutableString];
        
    }
    
    return stringM.lowercaseString;
}
- (NSString *)transformToPinyinFirstCapLetter{
    NSString *py = [self transformToPinyinFirstLetter];
    if (py.length>0) {
        return [py.uppercaseString substringToIndex:1];
    }else{
        return @"";
    }
}
-(NSString *)transformTolowercase{
    NSString *temp = [self lowercaseString];
    return temp;
}
-(NSString *)transformTouppercase{
    NSString *temp = [self uppercaseString];
    return temp;
}
@end
