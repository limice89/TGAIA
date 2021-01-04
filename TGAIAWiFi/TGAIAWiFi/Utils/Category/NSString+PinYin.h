//
//  NSString+PinYin.h
//  IEnjoyCar
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (PinYin)
///拼音 ->pinyin
-(NSString*)transformToPinyin;

///拼音首字母 -> py
- (NSString *)transformToPinyinFirstLetter;
///拼音首字母大写 ->P
- (NSString *)transformToPinyinFirstCapLetter;

//转小写
-(NSString *)transformTolowercase;

//转大写
-(NSString *)transformTouppercase;
@end

NS_ASSUME_NONNULL_END
