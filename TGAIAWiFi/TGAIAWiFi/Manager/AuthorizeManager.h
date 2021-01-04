//
//  AuthorizeManager.h
//  JinZhiTong
//
//  Created by admin on 2020/1/31.
//  Copyright © 2020 limice. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthorizeManager : NSObject
+(BOOL)detectionPhotoState:(void(^)())authorizedBlock;
+(BOOL)detectionCameraState:(void(^)())authorizedBlock;
@end

NS_ASSUME_NONNULL_END
