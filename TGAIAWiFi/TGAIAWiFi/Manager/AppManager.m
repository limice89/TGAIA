//
//  AppManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/21.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppManager.h"
#import "AdPageView.h"
#import "RootWebViewController.h"
#import "YYFPSLabel.h"

@implementation AppManager


+(void)appStart{
    //加载广告
    AdPageView *adView = [[AdPageView alloc] initWithFrame:kScreen_Bounds withTapBlock:^{
        RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[[RootWebViewController alloc] initWithUrl:@"http://www.hao123.com"]];
        [kRootViewController presentViewController:loginNavi animated:YES completion:nil];
    }];
    adView = adView;
}
#pragma mark ————— FPS 监测 —————
+(void)showFPS{
    YYFPSLabel *_fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = KScreenHeight - 55;
    _fpsLabel.right = KScreenWidth - 10;
    //    _fpsLabel.alpha = 0;
    [kAppWindow addSubview:_fpsLabel];
}
+ (void)filterBlank:(UITextField *)textField{
    return [[self class] filterBlank:textField maxLength:0];
}
+ (void)filterBlank:(UITextField *)textField maxLength:(NSInteger)length{
    //过滤空格
     NSString *tem = [[textField.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
     textField.text = tem;
    if (length>0&&tem.length>length) {
        textField.text = [tem substringToIndex:length];
    }
}
+(void)updateAppServer:(NSDictionary *)params completion:(VoidBlock_id)completion{
    /// 设置请求头
//    [PPNetworkHelper setValue:curUser.tokenId forHTTPHeaderField:@"Authorization"];
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_update_version) parameters:params success:^(id responseObject) {
//        if (completion) {
//            completion(responseObject);
//        }
//    } failure:^(NSString *error) {
//        [MBProgressHUD showInfoMessage:error];
//    }];
}
+ (UIViewController *)getCurrentVC {

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

    if (window.windowLevel != UIWindowLevelNormal){

        NSArray *windows = [[UIApplication sharedApplication] windows];

        for(UIWindow * tmpWin in windows){

            if (tmpWin.windowLevel == UIWindowLevelNormal){

                window = tmpWin;

                break;

            }

        }

    }

    UIViewController *result = window.rootViewController;

    while (result.presentedViewController) {

        result = result.presentedViewController;

    }

    if ([result isKindOfClass:[UITabBarController class]]) {

        result = [(UITabBarController *)result selectedViewController];

    }

    if ([result isKindOfClass:[UINavigationController class]]) {

        result = [(UINavigationController *)result topViewController];

    }

    return result;

    

}
@end
