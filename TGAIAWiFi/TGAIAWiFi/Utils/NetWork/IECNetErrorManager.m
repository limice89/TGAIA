//
//  IECNetErrorManager.m
//  IEnjoyCar
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import "IECNetErrorManager.h"

@implementation IECNetErrorManager
+ (void)handleReqRespouse:(id)responseObject successBlock:(void (^)(id detail ,NSString *msg))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock {
    NSDictionary *responseObjectDict = (NSDictionary *)responseObject;
    NSString *code = [NSString stringWithFormat:@"%@",[responseObjectDict objectForKey:@"code"]];
    NSString *msg = [responseObjectDict objectForKey:@"msg"];
    NSString *message = [responseObjectDict objectForKey:@"message"];
    NSString *error = [responseObjectDict objectForKey:@"error"];
    if ([code isEqualToString:@"200"]||[code isEqualToString:@"0"]||[code isEqualToString:@"-1"]) {
        //!>请求成功,想看接口 -1取消想看
        id data = responseObjectDict;
        successBlock(data,msg);
        successBlock = nil;
    }else if ([NSSTRING_CHECK_ISNULL(error) isEqualToString:@""]&&[NSSTRING_CHECK_ISNULL(code)isEqualToString:@""]) {
        //!>请求成功
        id data = responseObjectDict;
        successBlock(data,msg);
        successBlock = nil;
    }else if (![NSSTRING_CHECK_ISNULL(error) isEqualToString:@""]&&[NSSTRING_CHECK_ISNULL(code)isEqualToString:@""]) {
        //!>请求失败
        failBlock(message);
        failBlock = nil;
    }else{
        failBlock(msg);
        failBlock = nil;
        
    }
}
@end
