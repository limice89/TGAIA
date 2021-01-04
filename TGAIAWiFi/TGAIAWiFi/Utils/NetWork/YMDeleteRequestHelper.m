//
//  YMDeleteRequestHelper.m
//  yunMovie
//
//  Created by admin on 2020/9/24.
//  Copyright © 2020 limice. All rights reserved.
//

#import "YMDeleteRequestHelper.h"
#import <AFNetworking/AFNetworking.h>

@interface YMDeleteRequestHelper ()
@property (nonatomic, weak) AFHTTPSessionManager *sessionManager;
@end
@implementation YMDeleteRequestHelper
- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSNumber *)deleteWithUrl:(NSString *)url params:(id)params isShowHud:(BOOL)hudShow succBlock:(resultBlock)resultBlock error:(errorBlock)errorBlock {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    request.HTTPMethod = @"DELETE";
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted  error:nil];
    request.HTTPBody = jsonData;
    [request setValue:NSStringFormat(@"%@%@",@"Bearer",userManager.curUserInfo.access_token) forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return [self requestWithRequest:request succBlock:resultBlock error:errorBlock];
    
}
- (NSNumber *)postWithUrl:(NSString *)url params:(id)params isShowHud:(BOOL)hudShow  succBlock:(resultBlock)resultBlock error:(errorBlock)errorBlock{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    request.HTTPMethod = @"POST";
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted  error:nil];
    request.HTTPBody = jsonData;
    [request setValue:NSStringFormat(@"%@%@",@"Bearer",userManager.curUserInfo.access_token) forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return [self requestWithRequest:request succBlock:resultBlock error:errorBlock];
}
- (NSNumber *)requestWithRequest:(NSURLRequest *)request succBlock:(resultBlock)resultBlock error:(errorBlock)errorBlock {
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            errorBlock ? errorBlock(error) : nil;
        }
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responseObject;
            resultBlock ? resultBlock(dic) : nil;
        }
        
        if (response) {
            
        }
        
    }];
    NSNumber *requestId = @([dataTask taskIdentifier]);
    [dataTask resume];
    
    return requestId;
}

#pragma mark - lazy load
-(AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 20;
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain",@"application/json;charset=UTF-8", nil];
        
    }
    return _sessionManager;
}
@end
