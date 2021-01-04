//
//  AppManager.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/21.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 包含应用层的相关服务
 */
@interface AppManager : NSObject

#pragma mark ————— APP启动接口 —————
+(void)appStart;

#pragma mark ————— FPS 监测 —————
+(void)showFPS;

#pragma mark ————— 输入框过滤空格 —————
//过滤空格不限长度
+ (void)filterBlank:(UITextField *)textField;
//无最大长度 length 传0
+ (void)filterBlank:(UITextField *)textField maxLength:(NSInteger)length;
#pragma mark ————— 请求版本号更新 —————
+(void)updateAppServer:(NSDictionary *)params completion:(VoidBlock_id)completion;
+ (UIViewController *)getCurrentVC;
@end
