//
//  YMPlayerCountDownView.h
//  yunMovie
//
//  Created by admin on 2020/9/27.
//  Copyright © 2020 limice. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMPlayerCountDownView : UIView
@property (weak, nonatomic) IBOutlet UILabel *leftMinuteLabel; //分钟-十位数字
@property (weak, nonatomic) IBOutlet UILabel *rightMinuteLabel;//分钟-个位数字
@property (weak, nonatomic) IBOutlet UILabel *leftSecondsLabel; //秒-十位数字
@property (weak, nonatomic) IBOutlet UILabel *rightSecondsLabel;//秒-个位数字
@property (nonatomic, copy) NSString *posterUrl;
@property (nonatomic, copy) VoidBlock backBlock;// 返回上一级

@end

NS_ASSUME_NONNULL_END
