//
//  AppDelegate+AppService.m
//  yunMovie
//
//  Created by limice on 2020/08/01.
//  Copyright © 2020 yunMovie. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "OpenUDID.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "MainTabBarController.h"
#import "YMIntroductoryPagesHelper.h"



@implementation AppDelegate (AppService)
#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(backToLogin:)
        name:KNotificationBackToLogin
      object:nil];
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
}
#pragma mark ————— app语言 —————
- (void)checkLanguage{


}
#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[UIButton appearance] setExclusiveTouch:YES];
//    [[UIButton appearance] setShowsTouchWhenHighlighted:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    self.mainTabBar = [MainTabBarController new];
    self.window.rootViewController = self.mainTabBar;
}

#pragma mark ————— 初始化网络配置 —————
-(void)NetWorkConfig{
}

#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    DLog(@"设备IMEI ：%@",[OpenUDID value]);
//    if([userManager loadUserInfo]){
//
//        //如果有本地数据，先展示TabBar 随后异步自动登录
//        self.mainVC = [YMHomeViewController new];
//        RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:self.mainVC];
//        self.window.rootViewController = nav;
//        KPostNotification(KNotificationLoginStateChange, @YES)
//    }else{
//        //没有登录过，展示登录页面
//        KPostNotification(KNotificationLoginStateChange, @NO)
//    }
}
-(void)showWelcome{
    [YMIntroductoryPagesHelper showIntroductoryPageView:@[@"welcome_page_01.png", @"welcome_page_02.png", @"welcome_page_03.png"]];
}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    
//    if (loginSuccess) {//登陆成功加载主窗口控制器
//        
//        //为避免自动登录成功刷新tabbar
//        if (!self.mainVC) {
//            self.mainVC = [YMHomeViewController new];
//            RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:self.mainVC];
//            CATransition *anima = [CATransition animation];
//            anima.type = @"cube";//设置动画的类型
//            anima.subtype = kCATransitionFromRight; //设置动画的方向
//            anima.duration = 0.3f;
//            
//            self.window.rootViewController = nav;
//            
//            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
//            
//        }
//        
//    }else {//登陆失败加载登陆页面控制器
//        
//        self.mainVC = nil;
//        RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[YMLoginViewController new]];
//        
//        CATransition *anima = [CATransition animation];
//        anima.type = @"fade";//设置动画的类型
//        anima.subtype = kCATransitionFromRight; //设置动画的方向
//        anima.duration = 0.3f;
//        
//        self.window.rootViewController = loginNavi;
//        
//        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
//        
//    }
    //展示FPS
//    [AppManager showFPS];
}

- (void)backToLogin:(NSNotification *)notification{

}
#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) {//有网络
//        if ([userManager loadUserInfo] && !isLogin) {//有用户数据 并且 未登录成功 重新来一次自动登录
//            [userManager autoLoginToServer:^(BOOL success, NSString *des) {
//                if (success) {
//                    DLog(@"网络改变后，自动登录成功");
////                    [MBProgressHUD showSuccessMessage:@"网络改变后，自动登录成功"];
//                    KPostNotification(KNotificationAutoLoginSuccess, nil);
//                }else{
//                    [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
//                }
//            }];
//        }
        
    }else {//登陆失败加载登陆页面控制器
        [MBProgressHUD showTopTipMessage:IECLocalized(@"网络状态不佳") isWindow:YES];
    }
}
#pragma mark -- 微信支付初始化
-(void)initWxPay{
    [WXApi registerApp:YMThirdSDKWeChatAppKey universalLink:YMThirdSDKWeChatUniversalLink];
//    [WXApi startLogByLevel:WXLogLevelDetail logDelegate:self];
}
#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
//    [UMConfigure initWithAppkey:UMengKey channel:nil];
//
//    [self confitUShareSettings];
//    [self configUSharePlatforms];
    
    [YMUMengHelper UMAnalyticStart];
    [YMUMengHelper UMSocialStart];
}
#pragma mark 极光推送
-(void)initJPush:(NSDictionary *)launchOptions{
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:nil
                 apsForProduction:ProductSever
            advertisingIdentifier:advertisingId];
    if ([userManager loadUserInfo]) {
        DebugLog(@"-------%@",userManager.curUserInfo.userId);
            [JPUSHService setTags:[NSSet setWithObject:NSSTRING_CHECK_ISNULL(userManager.curUserInfo.userId)] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            //
        } seq:0];
        [JPUSHService setAlias:userManager.curUserInfo.userId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            //
        } seq:0];
    }
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}
-(void)initBMK{
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
//    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
//    BOOL ret = [mapManager start:@"cFw0LAmX2aaa3GF4eN2H3k6zd5Yj1Bg2" generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    // 要使用百度地图，请先启动BaiduMapManager
//    self.mapManager = [[BMKMapManager alloc]init];
    
    /**
     *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
//    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_COMMON]) {
//        NSLog(@"经纬度类型设置成功");
//    } else {
//        NSLog(@"经纬度类型设置失败");
//    }
    
    //   LDGySNHUXPlthKpHrGXkriUt8IT4CE5o
    BOOL ret = [mapManager start:BaiDuMapKey generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

}
#pragma mark ————— 配置第三方 —————



#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统。注：此方法是老方法，建议同时实现 application:openURL:options: 若APP不支持iOS9以下，可直接废弃当前，直接使用application:openURL:options:
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
//            跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
                if (resultStatus.integerValue==9000) {
                    NSString *result = [resultDic objectForKey:@"result"];
                    KPostNotification(YMAliPaySuccessNotification, nil);
                }else{
                    [kKeyWindow makeToast:@"支付失败,请重新支付"];
                }
            }];
            return YES;
        }else if ([url.host isEqualToString:@"pay"]){
            return [WXApi handleOpenURL:url delegate:[PayManager shareInstance]];
        }
//        if  ([OpenInstallSDK handLinkURL:url]){
//            return YES;
//        }
//        //微信支付
//        return [WXApi handleOpenURL:url delegate:[PayManager sharedPayManager]];
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_9_0){
        if (!result) {
            // 其他如支付等SDK的回调
                    if ([url.host isEqualToString:@"safepay"]) {
            //            跳转支付宝钱包进行支付，处理支付结果
                        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
                            if (resultStatus.integerValue==9000) {
                                NSString *result = [resultDic objectForKey:@"result"];
                                KPostNotification(YMAliPaySuccessNotification, nil);
                            }else{
                                [kKeyWindow makeToast:@"支付失败,请重新支付"];
                            }
                        }];
                        return YES;
                    }else if ([url.host isEqualToString:@"pay"]){
                        return [WXApi handleOpenURL:url delegate:[PayManager shareInstance]];
                    }
        }
    }
    return result;
}
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler
{
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
        return [WXApi handleOpenUniversalLink:userActivity delegate:[PayManager shareInstance]];
        
    }
    return YES;
}
#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                DLog(@"网络环境：未知网络");
                // 无网络
            case PPNetworkStatusNotReachable:
                DLog(@"网络环境：无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                DLog(@"网络环境：手机自带网络");
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                DLog(@"网络环境：WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                break;
        }
        
    }];
    
}


+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

@end
