//
//  YMIntroductoryPagesHelper.h
//  yunMovie
//
//  Created by admin on 2020/8/13.
//  Copyright © 2020 limice. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMIntroductoryPagesHelper : NSObject
+ (instancetype)shareInstance;

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray;
@end

NS_ASSUME_NONNULL_END
