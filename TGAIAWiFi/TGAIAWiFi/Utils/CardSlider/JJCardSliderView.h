//
//  JJCardSliderView.h
//  CardSliderDome
//
//  Created by  张礼栋 on 2019/12/10.
//  Copyright © 2019 mobile. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@protocol JJCardSliderViewDeleate <NSObject>

-(void)cardScrollToIndex:(NSInteger)index;

@end
@interface JJCardSliderView : UIView
@property (nonatomic, assign) id<JJCardSliderViewDeleate> delegate;
- (void)setCardListData:(NSArray *)cardList;
- (void)addTimer;
- (void)cancelTimer;
- (CGFloat)getViewHeight;
@end

NS_ASSUME_NONNULL_END
