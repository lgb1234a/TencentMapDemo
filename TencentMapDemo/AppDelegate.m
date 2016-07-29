//
//  AppDelegate.m
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "AppDelegate.h"
#import "QMapKit.h"

#define MapKey @"GSXBZ-TQ3RF-N24JZ-JMV73-D3DXQ-3OFB4"
@interface AppDelegate () <QAppKeyCheckDelegate>

@property (nonatomic, strong) QAppKeyCheck *keyCheck;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.keyCheck = [[QAppKeyCheck alloc] init];
    [self.keyCheck start:MapKey withDelegate:self];
    
    return YES;
}

// 这是QAppKeyCheckDelegate提供的key验证回调，用于检查传入的key值是否合法
-(void) notifyAppKeyCheckResult:(QErrorCode)errCode
{
    if (errCode == QErrorNone) {
        NSLog(@"验证成功");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
