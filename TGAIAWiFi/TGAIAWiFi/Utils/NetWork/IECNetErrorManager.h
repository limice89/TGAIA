//
//  IECNetErrorManager.h
//  IEnjoyCar
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IECNetErrorManager : NSObject
+ (void)handleReqRespouse:(id)responseObject successBlock:(void (^)(id detail ,NSString *msg))successBlock failBlock:(void(^)(NSString *errorMsg))failBlock;
@end

NS_ASSUME_NONNULL_END
