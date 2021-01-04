//
//  PayManager.h
//  IEnjoyCar
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayConfig.h"
//#import "UPPayPlugin.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
NS_ASSUME_NONNULL_BEGIN

@interface PayManager : NSObject<WXApiDelegate>
+ (instancetype)shareInstance;//!<单例,

#pragma mark - 银联支付
/**
 * @brief 通过银联支付.
 *
 * @param  tn : 接口给出的tn码.
 *
 * @return 无.
 */

#warning completeBlock参数中未统一:成功/失败/取消
- (void)payByUnionPayWithTn:(NSString *)tn controller:(UIViewController *)controller andCompleteBlock:(void(^)(NSString *result))completeBlock;

#pragma mark - 支付宝支付
/**
 * @brief 通过支付宝支付订单.
 *
 * @param  order : 和接口交互后获取的 (NSString *orderString = [goodsData objectForKey:@"signed_str"];).
 *
 * @return 无.
 */
- (void)payByAlipayWithOrder:(NSString *)orderInfo andCompleteBlock:(void(^)(NSDictionary *resultDic))completeBlock;

#pragma mark - 微信支付
/**
 * @brief 通过微信支付订单.
 *
 * @param orderForm : 从接口放回的订单信息
 *
 * @return 无.
 */
- (void)payByWXWithOrder:(NSDictionary *)orderForm andCompleteBlock:(void(^)(PAY_RESULT result))completeBlock;
@end
NS_ASSUME_NONNULL_END
