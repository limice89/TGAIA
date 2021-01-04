//
//  AppDelegate.h
//  yunMovie
//
//  Created by limice on 2020/08/01.
//  Copyright © 2020 yunMovie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>
@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) MainTabBarController *mainTabBar;
@end

