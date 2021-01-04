//
//  UserManager.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "IMManager.h"

typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeUnKnow = 1,//未知
    kUserLoginTypeWeChat = 2,//微信登录
    kUserLoginTypeQQ = 3,//QQ登录
    kUserLoginTypeWeibo = 4,//weibo登录
    kUserLoginTypeApple = 5,//iOS登录
    kUserLoginTypePwd,//账号登录
    kUserLoginTypeMobileCode, //验证码登录
};

typedef void (^successBlock)(BOOL success, NSString * des);

#define isLogin [UserManager sharedUserManager].isLogined
#define curUser [UserManager sharedUserManager].curUserInfo
#define userManager [UserManager sharedUserManager]
/**
 包含用户相关服务
 */
@interface UserManager : NSObject
+ (instancetype)sharedUserManager;//!<单例,
//单例
//SINGLETON_FOR_HEADER(UserManager)

//当前用户
@property (nonatomic, strong) UserInfo *curUserInfo;
@property (nonatomic, strong) NSDictionary *userInfoDict;
@property (nonatomic, strong) NSDictionary *userNamePwd;
@property (nonatomic, assign) UserLoginType loginType;
@property (nonatomic, assign) BOOL isLogined;

#pragma mark - ——————— 登录相关 ————————

/**
 三方登录

 @param loginType 登录方式
 @param openid openid
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType openid:(NSString *)openid  completion:(successBlock)completion;

/**
 带参登录

 @param loginType 登录方式
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(successBlock)completion;


/**
 退出登录

 @param completion 回调
 */
- (void)logout:(successBlock)completion;


/// 首页返回登录页
- (void)backToLogin;

/**
 加载缓存用户数据

 @return 是否成功
 */
-(BOOL)loadUserInfo;
/**
保存用户信息
*/
-(void)saveUserInfo;
/**
清楚用户缓存
*/
- (void)clearUserInfo;

@end
