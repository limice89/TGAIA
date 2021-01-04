//
//  JJPageControllerView.m
//  CardSliderDome
//
//  Created by  张礼栋 on 2019/12/10.
//  Copyright © 2019 mobile. All rights reserved.
//

#import "JJPageControllerView.h"
#import <Masonry/Masonry.h>

@implementation JJPageControllerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageControlArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setAllCount:(NSInteger)count {
    if (count == 0) {
        return;
    }
    
    for (UIView* subView in [self subviews]) {
        [subView removeFromSuperview];
    }
    [self.pageControlArray removeAllObjects];
    for (NSInteger i = 0; i < count; i++) {
        UIView* lineView = [UIView new];
        [self addSubview:lineView];
        if (i == 0) {
            lineView.backgroundColor = [UIColor blueColor];
        } else {
            lineView.backgroundColor = [UIColor grayColor];
        }
        CGFloat left = 15*i;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(left));
            make.width.equalTo(@11);
            make.top.bottom.equalTo(self);
            if (i == count-1) {
                make.right.equalTo(self);
            }
            if (i == 0) {
                make.left.equalTo(self);
            }
            
        }];
        [self.pageControlArray addObject:lineView];
    }
}

- (void)setIndex:(NSInteger)index {
    if (index >= self.pageControlArray.count || index < 0) {
        return;
    }
    for (UIView* view in self.pageControlArray) {
        NSInteger viewIndex = [self.pageControlArray indexOfObject:view];
        if (viewIndex == index) {
            view.backgroundColor = [UIColor blueColor];
        } else {
            view.backgroundColor = [UIColor grayColor];
        }
    }
}
@end
