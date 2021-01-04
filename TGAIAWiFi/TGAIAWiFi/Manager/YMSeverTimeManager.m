//
//  YMSeverTimeManager.m
//  yunMovie
//
//  Created by admin on 2020/9/27.
//  Copyright © 2020 limice. All rights reserved.
//

#import "YMSeverTimeManager.h"

@interface YMSeverTimeManager()
@property (nonatomic, strong) NSMutableArray *listerMap;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) NSTimeInterval timeStamp;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end
@implementation YMSeverTimeManager
static id _instance;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}
- (void)addListener:(id<TimerListenerProtocol>)listener {
    if(![self.listerMap containsObject:listener]){
        [self.listerMap addObject:listener];
        if(self.listerMap.count > 0){
            //启动
            [self requestSeverTime];
        }
    }
}
- (void)removeListener:(id<TimerListenerProtocol>)listener {
    if([self.listerMap containsObject:listener]){
        [self.listerMap removeObject:listener];
        if(self.listerMap.count == 0){
            //暂停
            dispatch_cancel(self.timer);
        }
    }
}
- (void)requestSeverTime{
    
    MSWeakSelf(weakSelf);
//    [YMSampleRequest requestServiceDateComplete:^(BOOL success, NSString * _Nonnull des) {
//        if (success) {
//            NSDate *date = [NSDate dateWithString:des format:KDateFormatter02];
//            weakSelf.timeStamp = [date timeIntervalSinceReferenceDate];
//            [weakSelf setupTime];
//        }
//    }];
//    [[HRMAttenRequestManager shareManger] getServerTime:^(NSDate * _Nonnull dateTime) {
    //这里换成自己业务的网络请求服务器时间
//        weakSelf.timeStamp = [dateTime timeIntervalSince1970];
//        [weakSelf setupTime];
//    }];
}



- (void)setupTime{
    
    
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeStamp += 1;
            NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:self.timeStamp];
            NSString *dateString = [self.formatter stringFromDate:date];
            
            [self.listerMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                id<TimerListenerProtocol> listener = obj;
                if([listener respondsToSelector:@selector(didChangeSeverTime:date:dateString:)]){
                    [listener didChangeSeverTime:self.timeStamp date:date dateString:dateString];
                }
            }];
        });
    });
    
    
}


- (dispatch_source_t)timer{
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_resume(self.timer);
    }
    return _timer;
}
- (NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = KDateFormatter02;
    }
    return _formatter;
}
- (NSMutableArray *)listerMap{
    if (!_listerMap) {
        _listerMap = [NSMutableArray array];
    }
    return _listerMap;
}
/**
 开启一个定时器

 @param target 定时器持有者
 @param timeInterval 执行间隔时间
 @param handler 重复执行事件
 */
void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer))
{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
        // 设置回调
    __weak __typeof(target) weaktarget  = target;
        dispatch_source_set_event_handler(timer, ^{
            if (!weaktarget)  {
                dispatch_source_cancel(timer);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (handler) handler(timer);
                });
            }
        });
        // 启动定时器
        dispatch_resume(timer);
}

@end
