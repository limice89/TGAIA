//
//  KeyValueStoreManager.m
//  yunMovie
//
//  Created by admin on 2020/8/27.
//  Copyright © 2020 limice. All rights reserved.
//

#import "KeyValueStoreManager.h"
#import "YTKKeyValueStore.h"
static KeyValueStoreManager *manager;
static NSString * const movie = @"movie";
static NSString * const keyvaluedb = @"keyvaluedb";
@implementation KeyValueStoreManager
+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
-(id)getCacheInfoWithKey:(NSString *)key{
    return [self getCacheInfoWithKey:key table:movie];
}
- (void)deleteObjectWithKey:(NSString *)key;{
    return [self deleteObjectWithKey:key table:movie];
}
-(void)storeDbWith:(id)object andkey:(NSString *)key{
    [self storeDbWith:object andkey:key table:movie];
}
/**
 存储数据
 */
- (void)storeDbWith:(id)object andkey:(NSString *)key table:(NSString *)table{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:keyvaluedb];
    [store createTableWithName:table];
    [store putObject:object withId:key intoTable:table];
}
/**
 获取数据
 */
- (id)getCacheInfoWithKey:(NSString *)key table:(NSString *)table{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:keyvaluedb];
    [store createTableWithName:table];
    return [store getObjectById:key fromTable:table];
}
- (void)storeDStringWith:(NSString *)string andkey:(NSString *)key table:(NSString *)table{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:keyvaluedb];
    [store createTableWithName:table];
    [store putString:string withId:key intoTable:table];
}
/**
 获取数据
 */
- (NSString *)getCacheStringWithKey:(NSString *)key table:(NSString *)table{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:keyvaluedb];
    [store createTableWithName:table];
    return [store getStringById:key fromTable:table];
}
- (void)deleteObjectWithKey:(NSString *)key table:(NSString *)table{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:keyvaluedb];
    [store createTableWithName:table];
    return [store deleteObjectById:key fromTable:table];
}
@end
