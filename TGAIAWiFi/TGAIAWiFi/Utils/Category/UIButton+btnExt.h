//
//  UIButton+btnExt.h
//  IEnjoyCar
//
//  Created by admin on 2019/11/26.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (btnExt)
+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont bgColor:(UIColor *)bgColor;
+ (UIButton *)createBtnWithFrame:(CGRect)frame img:(NSString *)imgName selectImg:(NSString *)selectImgName bgColor:(UIColor *)bgColor;
+ (UIButton *)createCustomBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont bgColor:(UIColor *)bgColor;
+ (UIButton *)createNoCornerBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont bgColor:(UIColor *)bgColor;


@end

NS_ASSUME_NONNULL_END
