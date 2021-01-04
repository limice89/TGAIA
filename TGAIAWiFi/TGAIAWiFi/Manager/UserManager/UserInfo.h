//
//  UserInfo.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/23.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@class infoData;
@interface UserInfo : BaseModel

@property (nonatomic, copy) NSString *access_token;//token
@property (nonatomic, copy) NSString *token_type;
@property (nonatomic, copy) NSString *refresh_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *isNewsPwd; //
@property (nonatomic, copy) NSString *pic; //头像
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickName;//用户昵称
@property (nonatomic, copy) NSString *enabled;
@property (nonatomic, copy) NSString *birthDate;//生日
@property (nonatomic, copy) NSString *city;//市
@property (nonatomic, copy) NSString *province;//省
@property (nonatomic, copy) NSString *sex;//性别 M男 F女 N保密
@property (nonatomic, copy) NSString *mobile;//手机号隐藏位数
@property (nonatomic, copy) NSString *userMobile; //手机号
@property (nonatomic, strong) NSNumber *status;//0禁用 1正常

@end
@interface infoData : NSObject

@end
