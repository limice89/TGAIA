//
//  PayConfig.h
//  IEnjoyCar
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

/**
* 银联支付:加第三方库:libstdc++.6.tbd QuartzCore.framework Security.framework
* 在工程的Build Settings中找到Other Linker Flags中添加-ObjC宏
* tn码从接口获取 支付成功后肯能需要调用接口通知支付结果
*
* 支付宝支付 AlipaySDK.bundle AlipaySDK.framework
*
* 微信支付 [WXApi registerApp:@"wx2d9f92094e649f74"]中的appkey须有支付能力,sdk在友盟中,微信的sdk集成的很好,在原有方法中扩展了支付能力
*/

#ifndef PayConfig_h
#define PayConfig_h
/*
 支付结果类型枚举
 */
typedef enum PAY_RESULT{
    PAY_RESULT_SUCCESS = 1,  //成功
    PAY_RESULT_FAILED,       //失败
    PAY_RESULT_CANCEL,       //取消
    PAY_RESULT_ING,       //处理中....
}PAY_RESULT;


#endif /* PayConfig_h */
