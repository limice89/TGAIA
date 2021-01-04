//
//  YMSeverTimeManager.h
//  yunMovie
//
//  Created by admin on 2020/9/27.
//  Copyright © 2020 limice. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YMSeverTimeManager;
//监听者需要实现的协议
@protocol TimerListenerProtocol <NSObject>
@required
- (void)didChangeSeverTime:(NSTimeInterval)timeStamp date:(NSDate *_Nullable)date dateString:(NSString *_Nullable)dateString;
@end
NS_ASSUME_NONNULL_BEGIN

@interface YMSeverTimeManager : NSObject
+ (instancetype)shareInstance;
void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer));

- (void)requestSeverTime;

- (void)addListener:(id<TimerListenerProtocol>)listener;
- (void)removeListener:(id<TimerListenerProtocol>)listener;
@end

NS_ASSUME_NONNULL_END
