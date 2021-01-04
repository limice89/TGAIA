//
//  YMBaseTableView.m
//  yunMovie
//
//  Created by admin on 2020/10/29.
//  Copyright © 2020 limice. All rights reserved.
//

#import "YMBaseTableView.h"

@implementation YMBaseTableView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"YMBaseTableView")]) {
        return YES;
//    }
//    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
