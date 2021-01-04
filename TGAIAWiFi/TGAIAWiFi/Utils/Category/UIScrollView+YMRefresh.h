//
//  UIScrollView+YMRefresh.h
//  yunMovie
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 limice. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (YMRefresh)


- (void)setRefreshWithHeaderBlock:(nullable void(^)(void))headerBlock
                      footerBlock:(nullable void(^)(void))footerBlock;


- (void)headerBeginRefreshing;
- (void)headerEndRefreshing;
- (void)footerEndRefreshing;
- (void)footerNoMoreData;

- (void)hideHeaderRefresh;
- (void)hideFooterRefresh;


@end

NS_ASSUME_NONNULL_END
