//
//  MKLFlowLayout.h
//  Macaroon
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 limice. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MKLWaterFlowVerticalEqualWidth = 0, /** 竖向瀑布流 item等宽不等高 */
    MKLWaterFlowHorizontalEqualHeight = 1, /** 水平瀑布流 item等高不等宽 不支持头脚视图*/
    MKLWaterFlowVerticalEqualHeight = 2,  /** 竖向瀑布流 item等高不等宽 */
    MKLWaterFlowHorizontalGrid = 3,  /** 特为国务院客户端原创栏目滑块样式定制-水平栅格布局  仅供学习交流*/
    MKLLineWaterFlow = 4 /** 线性布局 待完成，敬请期待 */
} MKLWaterFlowLayoutStyle; //样式

@class MKLFlowLayout;

@protocol MKLFlowLayoutDelegate <NSObject>

/**
 返回item的大小
 注意：根据当前的瀑布流样式需知的事项：
 当样式为MKLWaterFlowVerticalEqualWidth 传入的size.width无效 ，所以可以是任意值，因为内部会根据样式自己计算布局
 MKLWaterFlowHorizontalEqualHeight 传入的size.height无效 ，所以可以是任意值 ，因为内部会根据样式自己计算布局
 MKLWaterFlowHorizontalGrid   传入的size宽高都有效， 此时返回列数、行数的代理方法无效，
 MKLWaterFlowVerticalEqualHeight 传入的size宽高都有效， 此时返回列数、行数的代理方法无效
 */
- (CGSize)waterFlowLayout:(MKLFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/** 头视图Size */
-(CGSize )waterFlowLayout:(MKLFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section;
/** 脚视图Size */
-(CGSize )waterFlowLayout:(MKLFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section;

@optional //以下都有默认值
/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(MKLFlowLayout *)waterFlowLayout;
/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(MKLFlowLayout *)waterFlowLayout;

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(MKLFlowLayout *)waterFlowLayout;
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(MKLFlowLayout *)waterFlowLayout;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(MKLFlowLayout *)waterFlowLayout;

@end
@interface MKLFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) id<MKLFlowLayoutDelegate>delegate;
/** 瀑布流样式*/
@property (nonatomic, assign) MKLWaterFlowLayoutStyle  flowLayoutStyle;
@end
