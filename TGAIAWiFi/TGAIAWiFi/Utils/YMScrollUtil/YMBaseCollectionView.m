//
//  YMBaseCollectionView.m
//  yunMovie
//
//  Created by admin on 2020/10/29.
//  Copyright © 2020 limice. All rights reserved.
//

#import "YMBaseCollectionView.h"

@implementation YMBaseCollectionView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // Ignore other gesture than pan
//    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"YMBaseCollectionView")]) {
//        return YES;
//    }
//    return NO;
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
