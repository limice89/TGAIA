//
//  YMSampleRequest.h
//  yunMovie
//
//  Created by admin on 2020/8/13.
//  Copyright © 2020 limice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMDeleteRequestHelper.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^completionBlock)(BOOL success, NSString * des);
typedef void (^pictureBlock)(BOOL success, NSString * sourceUrl,NSString *filePath,NSString *allUrl);
typedef void (^CompleteBlock)(BOOL success, NSString * des, id __nullable responseObject);
@interface YMSampleRequest : NSObject

@end

NS_ASSUME_NONNULL_END
