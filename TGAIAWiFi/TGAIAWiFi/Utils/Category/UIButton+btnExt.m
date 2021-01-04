//
//  UIButton+btnExt.m
//  IEnjoyCar
//
//  Created by admin on 2019/11/26.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import "UIButton+btnExt.h"




@implementation UIButton (btnExt)

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont bgColor:(UIColor *)bgColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:bgColor];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:titleFont];
    return button;
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame img:(NSString *)imgName selectImg:(NSString *)selectImgName bgColor:(UIColor *)bgColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:bgColor];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImgName] forState:UIControlStateHighlighted];
    return button;
}
+ (UIButton *)createCustomBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont bgColor:(UIColor *)bgColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:bgColor];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = SYSTEMFONT(titleFont);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    return button;
    
}
+ (UIButton *)createNoCornerBtnWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont bgColor:(UIColor *)bgColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundColor:bgColor];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    return button;
}


@end
