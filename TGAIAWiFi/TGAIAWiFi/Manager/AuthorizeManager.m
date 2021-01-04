//
//  AuthorizeManager.m
//  JinZhiTong
//
//  Created by admin on 2020/1/31.
//  Copyright © 2020 limice. All rights reserved.
//

#import "AuthorizeManager.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <CoreLocation/CLLocationManager.h>

@interface AuthorizeManager ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation AuthorizeManager
//相册权限
+(BOOL)detectionPhotoState:(void(^)())authorizedBlock
 {
     BOOL isAvalible = NO;
         PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
         //用户尚未授权
         if (authStatus == PHAuthorizationStatusNotDetermined)
         {
             [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
             if (status == PHAuthorizationStatusAuthorized)
             {
                if (authorizedBlock)
                {
                    authorizedBlock();
                }
             }}];
          }
          //用户已经授权
          else if (authStatus == PHAuthorizationStatusAuthorized)
          {
              isAvalible = YES;
        
              if (authorizedBlock)
              {
                 authorizedBlock();
              }
          }
          //用户拒绝授权
          else
          {
              //提示用户开启相册权限
              [kKeyWindow makeToast:@"开启相册权限"];
          }

      return isAvalible;

}
//相机权限
+(BOOL)detectionCameraState:(void(^)())authorizedBlock
{
    BOOL isAvalible = NO;

    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    //用户尚未授权
    if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        
            if (granted)
            {
                if (authorizedBlock)
                {
                    authorizedBlock();
                }
            }
        }];
    }
    //用户已经授权
    else if (authStatus == AVAuthorizationStatusAuthorized)
    {
        isAvalible = YES;
    
        if (authorizedBlock)
        {
            authorizedBlock();
        }
    }
    //用户拒绝授权
    else
    {
        //提示用户开启相机权限
        [kKeyWindow makeToast:@"开启相机权限"];
    
    }

    return isAvalible;

}

@end
