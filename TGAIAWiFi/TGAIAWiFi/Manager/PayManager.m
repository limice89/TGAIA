//
//  PayManager.m
//  IEnjoyCar
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import "PayManager.h"

@interface PayManager ()
@property (nonatomic, copy) void(^unCompleteBlock)(NSString *result);//!<银联回调block.
@property (nonatomic, copy) void(^wxCompleteBlock)(PAY_RESULT result);//!<微信回调block.

@end

static PayManager * sharedInstance = nil;
/*
 支付宝错误码:
 9000 订单支付成功
 8000 正在处理中
 4000 订单支付失败
 6001 用户中途取消
 6002 网络连接出错
 */

/*
 微信支付错误码:
  0    成功    展示成功页面
 -1    错误    可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
 -2    用户取消    无需处理。发生场景：用户不支付了，点击取消，返回APP。
 */

@implementation PayManager
+ (instancetype)shareInstance {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 银联支付

//- (void)payByUnionPayWithTn:(NSString *)tn controller:(UIViewController *)controller andCompleteBlock:(void(^)(NSString *result))completeBlock {
//    self.unCompleteBlock = [completeBlock copy];
//    [UPPayPlugin startPay:tn mode:UPPAY_MODE viewController:controller delegate:self];
//}

#pragma mark UPPayPluginDelegate methods (银联代理方法)
//-(void)UPPayPluginResult:(NSString*)result {
//    self.unCompleteBlock (result);
//    self.unCompleteBlock = nil;
//}

#pragma mark - 支付宝支付

- (void)payByAlipayWithOrder:(NSString *)orderInfo andCompleteBlock:(void(^)(NSDictionary *resultDic))completeBlock {
        [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:AliPayScheme callback:^(NSDictionary *resultDic) {
            
//            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
//            PAY_RESULT result;
//            switch (resultStatus.integerValue) {
//                case 9000:
//                    result = PAY_RESULT_SUCCESS;
//                    break;
//                case 8000:
//                    result = PAY_RESULT_ING;
//                    break;
//                case 4000:
//                    result = PAY_RESULT_FAILED;
//                    break;
//                case 6001:
//                    result = PAY_RESULT_CANCEL;
//                    break;
//                case 6002:
//                    result = PAY_RESULT_FAILED;
//                    break;
//                default:
//                    break;
//            }
            completeBlock(resultDic);
        }];
}

- (void)payByWXWithOrder:(NSDictionary *)orderForm andCompleteBlock:(void(^)(PAY_RESULT result))completeBlock {
    //!<从接口返回数据,字段和接口协商.
    PayReq *weChatPayReq = [[PayReq alloc] init];
    weChatPayReq.partnerId = [orderForm objectForKey:@"partnerId"];
    weChatPayReq.prepayId = [orderForm objectForKey:@"prepayId"];
    weChatPayReq.package = [orderForm objectForKey:@"packageValue"];
    weChatPayReq.nonceStr = [orderForm objectForKey:@"nonceStr"];
    NSString *stampString = [orderForm objectForKey:@"timeStamp"];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *stampNumber = [numberFormatter numberFromString:stampString];
    weChatPayReq.timeStamp = [stampNumber unsignedIntValue];
    weChatPayReq.sign = [orderForm objectForKey:@"sign"];
    [WXApi sendReq:weChatPayReq completion:^(BOOL success) {
        if (success) {
            self.wxCompleteBlock = completeBlock;
        }
    }];
//    BOOL re = [WXApi sendReq:weChatPayReq];
//    DLog(@"%zi",re);
//    self.wxCompleteBlock = completeBlock;
}

#pragma mark 微信支付代理方法 从appdele返回
/*
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
 if ([url.host isEqualToString:@"pay"]) {//!<从微信支付返回.
 return [WXApi handleOpenURL:url delegate:[PayManager shareInstance]];
 }
 return YES;
 }
 */

-(void) onResp:(BaseResp*)resp {
    PAY_RESULT result;
    switch (resp.errCode) {
        case 0:
            result = PAY_RESULT_SUCCESS;
            break;
        case -1:
            result = PAY_RESULT_FAILED;
        case -2:
            result = PAY_RESULT_CANCEL;
        default:
            break;
    }
    self.wxCompleteBlock (result);
    self.wxCompleteBlock = nil;
}
@end
