//
//  YMPickerView.h
//  yunMovie
//
//  Created by limice on 2020/9/8.
//  Copyright © 2020 limice. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YMPickerView;

@protocol YMPickViewDataSource <NSObject>

@required

- (NSInteger)numberOfComponentsInPickerView:(YMPickerView *)pickerView;

- (NSInteger)pickerView:(YMPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol YMPickViewDelegate <NSObject>

- (NSString *)pickerView:(YMPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)pickView:(YMPickerView *)pickerView confirmButtonClick:(UIButton *)button;
- (void)pickView:(YMPickerView *)pickerView cancelButtonClick:(UIButton *)button;

@optional
- (NSAttributedString *)pickerView:(YMPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)componen;

- (void)pickerView:(YMPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
@interface YMPickerView : UIView
@property (nonatomic, weak) id<YMPickViewDelegate> delegate;
@property (nonatomic, weak) id<YMPickViewDataSource> dataSource;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
// 选中某一行
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
// 获取当前选中的row
- (NSInteger)selectedRowInComponent:(NSInteger)component;

//刷新某列数据
-(void)pickReloadComponent:(NSInteger)component;
//刷新数据
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
