//
//  AppDelegate+AppService.h
//  yunMovie
//
//  Created by limice on 2020/08/01.
//  Copyright © 2020 yunMovie. All rights reserved.
//



#import "AppDelegate.h"


#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppService)

//初始化服务
-(void)initService;

//检测app语言
- (void)checkLanguage;

//初始化 window
-(void)initWindow;

//初始化 微信支付
-(void)initWxPay;

//初始化 UMeng
-(void)initUMeng;

//初始化极光推送
-(void)initJPush:(NSDictionary *)launchOptions;

//初始化百度地图
-(void)initBMK;

//初始化用户系统
-(void)initUserManager;

//监听网络状态
- (void)monitorNetworkStatus;

//初始化网络配置
-(void)NetWorkConfig;

//欢迎页
-(void)showWelcome;
//配置播放器相关
-(void)configPlayer;

//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;
@end

NS_ASSUME_NONNULL_END
