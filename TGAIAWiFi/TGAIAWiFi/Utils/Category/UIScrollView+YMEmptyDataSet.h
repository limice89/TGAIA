//
//  UIScrollView+YMEmptyDataSet.h
//  yunMovie
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 limice. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^YM_ClickBlock)(void);
@interface UIScrollView (YMEmptyDataSet)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic) YM_ClickBlock clickBlock;                // 点击事件
@property (nonatomic, assign) CGFloat offset;               // 垂直偏移量
@property (nonatomic, strong) NSString *emptyText;          // 空数据显示内容
@property (nonatomic, strong) UIImage *emptyImage;          // 空数据的图片


- (void)setupEmptyData:(YM_ClickBlock)clickBlock;
- (void)setupEmptyDataText:(NSString *)text tapBlock:(YM_ClickBlock)clickBlock;
- (void)setupEmptyDataText:(NSString *)text verticalOffset:(CGFloat)offset tapBlock:(YM_ClickBlock)clickBlock;
- (void)setupEmptyDataText:(NSString *)text verticalOffset:(CGFloat)offset emptyImage:(UIImage *)image tapBlock:(YM_ClickBlock)clickBlock;
@end

NS_ASSUME_NONNULL_END
