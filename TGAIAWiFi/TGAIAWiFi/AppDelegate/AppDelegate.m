//
//  AppDelegate.m
//  yunMovie
//
//  Created by limice on 2019/11/23.
//  Copyright © 2019 yunMovie. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化window
    [self initWindow];
    
    //初始化网络请求配置
    [self NetWorkConfig];
    
    //百度地图初始化
    [self initBMK];
    
    [self initWxPay];
    
    //UMeng初始化
    [self initUMeng];
    
    //JPush推送
    [self initJPush:launchOptions];
    
    //初始化app服务
    [self initService];
    
    //检测系统语言
    [self checkLanguage];
    
    //初始化IM
//    [[IMManager sharedIMManager] initIM];
    
    //初始化用户系统
    [self initUserManager];
    
    //网络监听
    [self monitorNetworkStatus];
    
    //欢迎页
//    [self showWelcome];
    
    
    //广告页
//    [AppManager appStart];
    
    return YES;
}




@end
