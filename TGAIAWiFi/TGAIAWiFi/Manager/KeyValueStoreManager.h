//
//  KeyValueStoreManager.h
//  yunMovie
//
//  Created by admin on 2020/8/27.
//  Copyright © 2020 limice. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyValueStoreManager : NSObject
+ (instancetype)manager;

/**
 获取所有缓存信息
 
 @return 数据对象
 */
- (id)getCacheInfoWithKey:(NSString *)key;
/**
删除key对应缓存信息

*/
- (void)deleteObjectWithKey:(NSString *)key;
/**
 存储缓存
 
 @param object 存储信息
 @param key 信息的key
 */
- (void)storeDbWith:(id)object andkey:(NSString *)key;
/**
 存储数据
 */
- (void)storeDbWith:(id)object andkey:(NSString *)key table:(NSString *)table;
/**
删除key对应缓存信息

 @param key key
 @param table table
*/
- (void)deleteObjectWithKey:(NSString *)key table:(NSString *)table;
/**
 获取数据
 */
- (id)getCacheInfoWithKey:(NSString *)key table:(NSString *)table;
//存储字符串
- (void)storeDStringWith:(NSString *)string andkey:(NSString *)key table:(NSString *)table;
//获取存储的字符串
- (NSString *)getCacheStringWithKey:(NSString *)key table:(NSString *)table;
@end

NS_ASSUME_NONNULL_END
