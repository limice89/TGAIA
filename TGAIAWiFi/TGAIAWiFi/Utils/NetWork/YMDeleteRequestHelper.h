//
//  YMDeleteRequestHelper.h
//  yunMovie
//
//  Created by admin on 2020/9/24.
//  Copyright © 2020 limice. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMDeleteRequestHelper : NSObject
typedef void (^resultBlock)(NSDictionary *dic);
typedef void (^errorBlock)(NSError* error);


/**
 Delete 请求方式

 @param url url
 @param params 参数 可传数组
 @param hudShow 是否显示hud
 @param resultBlock 后台返回回调
 @param errorBlock 失败回调
 @return 请求id
 */
- (NSNumber *)deleteWithUrl:(NSString *)url params:(id)params isShowHud:(BOOL)hudShow  succBlock:(resultBlock)resultBlock error:(errorBlock)errorBlock;

/**
 Delete 请求方式

 @param url url
 @param params 参数 可传数组
 @param hudShow 是否显示hud
 @param resultBlock 后台返回回调
 @param errorBlock 失败回调
 @return 请求id
 */
- (NSNumber *)postWithUrl:(NSString *)url params:(id)params isShowHud:(BOOL)hudShow  succBlock:(resultBlock)resultBlock error:(errorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
