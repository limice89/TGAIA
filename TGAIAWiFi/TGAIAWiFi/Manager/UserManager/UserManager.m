//
//  UserManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "UserManager.h"
#import <UMShare/UMShare.h>
static UserManager * sharedInstance = nil;
@implementation UserManager

//SINGLETON_FOR_CLASS(UserManager);
+ (instancetype)sharedUserManager{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark ————— 三方登录 —————
-(void)login:(UserLoginType )loginType openid:(NSString *)openid  completion:(successBlock)completion{
    NSDictionary *params = @{
        @"principal":NSSTRING_CHECK_ISNULL(openid),
        @"appType":@(loginType)
    };
    self.loginType = loginType;
    return [self loginToServer:params completion:completion];
}

#pragma mark ————— 带参数登录 —————
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(successBlock)completion{
    //友盟登录类型
    UMSocialPlatformType platFormType;
    
    if (loginType == kUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    }else if (loginType == kUserLoginTypeWeChat){
        platFormType = UMSocialPlatformType_WechatSession;
    }else if (loginType == kUserLoginTypeWeibo){
        platFormType = UMSocialPlatformType_Sina;
    }else{
        platFormType = UMSocialPlatformType_UnKnown;
    }
    //第三方登录
    if (loginType != kUserLoginTypePwd&& loginType != kUserLoginTypeMobileCode) {
        [MBProgressHUD showActivityMessageInView:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            } else {
                
                UMSocialUserInfoResponse *resp = result;
//                
//                // 授权信息
//                NSLog(@"QQ uid: %@", resp.uid);
//                NSLog(@"QQ openid: %@", resp.openid);
//                NSLog(@"QQ accessToken: %@", resp.accessToken);
//                NSLog(@"QQ expiration: %@", resp.expiration);
//                
//                // 用户信息
//                NSLog(@"QQ name: %@", resp.name);
//                NSLog(@"QQ iconurl: %@", resp.iconurl);
//                NSLog(@"QQ gender: %@", resp.unionGender);
//                
//                // 第三方平台SDK源数据
//                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                
                //登录参数
                NSDictionary *params = @{@"openid":resp.openid, @"nickname":resp.name, @"photo":resp.iconurl, @"sex":[resp.unionGender isEqualToString:@"男"]?@1:@2, @"cityname":resp.originalResponse[@"city"], @"fr":@(loginType)};
                
                self.loginType = loginType;
                //登录到服务器
                [self loginToServer:params completion:completion];
            }
        }];
    }else{
        //账号登录 暂未提供
        self.loginType = loginType;
        [self loginType:loginType params:params completion:completion];
    }
}

#pragma mark ————— 手动登录到服务器 —————
-(void)loginType:(UserLoginType)type params:(NSDictionary *)params completion:(successBlock)completion{
    
    NSString *url = URL_user_login;
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,url) parameters:params success:^(id responseObject) {
        UserInfo *userinfo = [UserInfo modelWithDictionary:responseObject];
        self.curUserInfo = userinfo;
        [PPNetworkHelper setValue:NSStringFormat(@"%@%@",@"Bearer",userinfo.access_token) forHTTPHeaderField:@"Authorization"];
        [self requestUserInfo:^(BOOL success, NSString *des) {
            if (completion) {
                completion(YES,@"登录成功");
            }
        }];
    } failure:^(NSString *error) {
        if (completion) {
            completion(NO,error);
        }
    }];
    
}
#pragma mark ————— 三方登录到服务器接口 —————
-(void)loginToServer:(NSDictionary *)params completion:(successBlock)completion{
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_third_login) parameters:params success:^(id responseObject) {
        UserInfo *userinfo = [UserInfo modelWithDictionary:responseObject];
        self.curUserInfo = userinfo;
        [PPNetworkHelper setValue:NSStringFormat(@"%@%@",@"Bearer",userinfo.access_token) forHTTPHeaderField:@"Authorization"];
        [self requestUserInfo:^(BOOL success, NSString *des) {
            if (completion) {
                completion(YES,@"登录成功");
            }
        }];
    } failure:^(NSString *error) {
        if (completion) {
            completion(NO,error);
        }
    }];
}
#pragma mark ————— 请求用户信息 —————
-(void)requestUserInfo:(successBlock)completion{
    [PPNetworkHelper GET:NSStringFormat(@"%@%@",URL_main,URL_userInfo) parameters:@{} success:^(id responseObject) {
        UserInfo *userinfo = [UserInfo modelWithDictionary:[responseObject objectForKey:@"data"]];
        self.curUserInfo.birthDate = userinfo.birthDate;
        self.curUserInfo.city = userinfo.city;
        self.curUserInfo.province = userinfo.province;
        self.curUserInfo.sex = userinfo.sex;
        self.curUserInfo.mobile = userinfo.mobile;
        self.curUserInfo.userMobile = userinfo.userMobile;
        self.curUserInfo.pic = userinfo.pic;
        self.curUserInfo.status = userinfo.status;
        [self saveUserInfo];
        self.isLogined = YES;
        if (completion) {
            completion(YES,@"登录成功");
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(NO,error);
        }
    }];
}

#pragma mark ————— 登录成功处理 —————
-(void)LoginSuccess:(id )responseObject completion:(successBlock)completion{
    if (ValidDict(responseObject)) {
        self.userInfoDict = responseObject;
        UserInfo *userinfo = [UserInfo modelWithDictionary:responseObject];
            if ([userinfo.code isEqualToString:@"200"]) {
                self.curUserInfo = userinfo;
                [self saveUserInfo];
                self.isLogined = YES;
                if (completion) {
                    completion(YES,@"登录成功");
                }
//                KPostNotification(KNotificationLoginStateChange, @YES);
            }else{
                if (completion) {
                    completion(NO,@"登录返回数据异常");
                }
                KPostNotification(KNotificationLoginStateChange, @NO);
            }
    }else{
        if (completion) {
            completion(NO,@"登录返回数据异常");
        }
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
    
}
#pragma mark ————— 储存用户信息 —————
-(void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
        [cache.diskCache setObject:dic forKey:KUserModelCache];
    }
    
}
#pragma mark ————— 加载缓存的用户信息 —————
-(BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [UserInfo modelWithJSON:userDic];
        self.isLogined = YES;
        [PPNetworkHelper setValue:NSStringFormat(@"%@%@",@"Bearer",self.curUserInfo.access_token) forHTTPHeaderField:@"Authorization"];
        return YES;
    }
    return NO;
}
#pragma mark ————— 被踢下线 —————
-(void)onKick{
    STAlertView *alertView = [STAlertView showTitle:IECLocalized(@"登录异常") image:nil message:IECLocalized(@"请重新登录") buttonTitles:@[IECLocalized(@"确定")] handler:^(NSInteger index) {
        [self logout:nil];
    }];
    
}
#pragma mark ————— 退出登录 —————
- (void)logout:(void (^)(BOOL, NSString *))completion{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
    
    [[IMManager sharedIMManager] IMLogout];
    
    self.curUserInfo = nil;
    self.isLogined = NO;

//    //移除缓存
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}
-(void)backToLogin{
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        
    //    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
        
        [[IMManager sharedIMManager] IMLogout];
        
        self.curUserInfo = nil;
        self.isLogined = NO;

    //    //移除缓存
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        [cache removeAllObjects];
        [cache removeAllObjectsWithBlock:^{
        }];
        
        KPostNotification(KNotificationBackToLogin, nil);
}
- (void)clearUserInfo{
        self.curUserInfo = nil;
        self.isLogined = NO;

    //    //移除缓存
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        [cache removeAllObjects];
        [cache removeAllObjectsWithBlock:^{
        }];
}
@end
