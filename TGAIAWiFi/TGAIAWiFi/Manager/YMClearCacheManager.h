//
//  YMClearCacheManager.h
//  yunMovie
//
//  Created by admin on 2020/9/25.
//  Copyright © 2020 limice. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMClearCacheManager : NSObject
//计算 文件夹及sdwebimage 中缓存大小
+ (float)folderSizeAtPath:(NSString *)path;
//清理 文件夹及sdwebimage 中缓存
+ (void)clearCache:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
