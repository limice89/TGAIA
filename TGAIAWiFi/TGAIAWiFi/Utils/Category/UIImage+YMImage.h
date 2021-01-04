//
//  UIImage+YMImage.h
//  yunMovie
//
//  Created by admin on 2020/8/25.
//  Copyright © 2020 limice. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YMImage)
/** 截屏 */
+(instancetype)ym_snapshotCurrentcreen;

/** 高效添加圆角 */
-(UIImage *)ym_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;
/** 图片拉伸 */
-(UIImage *)ym_imageTop:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;
@end

NS_ASSUME_NONNULL_END
