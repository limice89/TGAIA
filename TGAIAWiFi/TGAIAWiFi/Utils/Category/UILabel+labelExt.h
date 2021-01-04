//
//  UILabel+labelExt.h
//  IEnjoyCar
//
//  Created by admin on 2019/11/26.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (labelExt)
/**
 *  字间距
 */
@property (nonatomic,assign)CGFloat characterSpace;

/**
 *  行间距
 */
@property (nonatomic,assign)CGFloat lineSpace;

/**
 *  关键字
 */
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,strong)UIFont *keywordsFont;
@property (nonatomic,strong)UIColor *keywordsColor;

/**
 *  下划线
 */
@property (nonatomic,copy)NSString *underlineStr;
@property (nonatomic,strong)UIColor *underlineColor;
+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor *)color;
- (CGFloat)heightAfterAdjustText;
+ (UILabel *)labelWithTextColor:(UIColor *)color textFont:(UIFont *)font textAligment:(NSTextAlignment)alignment;
/**
 *  计算label宽高，必须调用
 *
 *  @param maxWidth 最大宽度
 *
 *  @return label的size
 */
- (CGSize)getLableSizeWithMaxWidth:(CGFloat)maxWidth;
@end

NS_ASSUME_NONNULL_END
