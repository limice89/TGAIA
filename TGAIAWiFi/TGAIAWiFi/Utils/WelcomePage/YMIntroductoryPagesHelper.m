//
//  YMIntroductoryPagesHelper.m
//  yunMovie
//
//  Created by admin on 2020/8/13.
//  Copyright © 2020 limice. All rights reserved.
//

#import "YMIntroductoryPagesHelper.h"
#import "YMIntroductoryPagesView.h"

@interface YMIntroductoryPagesHelper ()
@property (weak, nonatomic) UIWindow *curWindow;

@property (strong, nonatomic) YMIntroductoryPagesView *curIntroductoryPagesView;

@end
@implementation YMIntroductoryPagesHelper
static YMIntroductoryPagesHelper *shareInstance_ = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance_ = [[YMIntroductoryPagesHelper alloc] init];
    });
    
    return shareInstance_;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray
{
    if (![YMIntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [YMIntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [YMIntroductoryPagesView pagesViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) images:imageArray];
    }
    
    [YMIntroductoryPagesHelper shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[YMIntroductoryPagesHelper shareInstance].curWindow addSubview:[YMIntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
}
@end
