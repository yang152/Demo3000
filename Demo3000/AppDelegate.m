//
//  AppDelegate.m
//  VLionAdSDKDemo
//
//  Created by 张旭 on 2017/10/17.
//  Copyright © 2017年 cnlive. All rights reserved.
//

#import "AppDelegate.h"
#import <VLionADSDK/VLNAdSDK.h>
#import "ViewController.h"

@interface AppDelegate ()<VLNSplashAdDelegate>
@property (nonatomic, strong) VLNSplashAd *ad;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (self.window == nil) {
        UIWindow *keyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        keyWindow.backgroundColor = [UIColor whiteColor];
        self.window = keyWindow;
    }
    
    [[VLNAdSDKManager defaultManager] registerAppId:@"50017" finishBlock:^(BOOL success, NSError * _Nonnull error) {
        
        if (success) {
            VLNSplashAd *ad = [[VLNSplashAd alloc] initWithSceneName:@"scene"];
            ad.delegate = self;
            self.ad = ad;
            [ad loadAdAndShowInWindow:self.window];
        }
        else {
            NSLog(@"sdk初始化失败");
        }
        
    }];
    
    UIViewController *controller = [[ViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.navigationBar.translucent = NO;
    [navController setViewControllers:@[controller]];

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    

    
    return YES;
}

- (void)vl_splashAdDidLoad:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd DidLoad");
}

- (void)vl_splashAd:(VLNSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"VLNSplashAd didFailWithError");
}

- (void)vl_splashAdExposured:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd splashAdExposured");
}

- (void)vl_splashAdDidClick:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd splashAdDidClick");
}

- (void)vl_splashAdWillClose:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd splashAdWillClose");
}

- (void)vl_splashAdDidClose:(VLNSplashAd *)splashAd {
    NSLog(@"VLNSplashAd splashAdDidClose");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
