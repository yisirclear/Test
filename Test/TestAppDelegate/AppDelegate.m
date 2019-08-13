//
//  AppDelegate.m
//  Test
//
//  Created by yzq on 17/8/31.
//  Copyright © 2017年 tango. All rights reserved.
//

#import "AppDelegate.h"
#import <Teacher.h>
#import <Teachers.h>
#import <WeexSDK.h>
#import "ViewController.h"
#import <WXDevtool/WXDevTool.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)weexSDKSetup {
    [WXAppConfiguration setAppGroup:@"Test"];
    [WXAppConfiguration setAppName:@"Test"];
    [WXAppConfiguration setAppVersion:@"1.0"];
    [WXSDKEngine initSDKEnvironment];
    
    [WXDevTool setDebug:YES];
    
    [WXLog setLogLevel:WXLogLevelWarning];
    
    //
    
}

- (void)rsString:(NSString *)string {
    NSMutableString *mString = [[NSMutableString alloc] initWithString:string];
    
    for (int i = 0; i < (string.length + 1) / 2; i++) {
        [mString replaceCharactersInRange:NSMakeRange(i, 1) withString:[string substringWithRange:NSMakeRange(string.length - 1 - i, 1)]];
        [mString replaceCharactersInRange:NSMakeRange(string.length - i - 1, 1) withString:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSLog(@"%@",mString);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self weexSDKSetup];
    
    NSNumber *cc = @(1);
    NSLog(@"%d",[cc boolValue]);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *v = [[ViewController alloc] init];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:v];
    self.window.rootViewController = nv;
    
    [self.window makeKeyAndVisible];
    
    
    //[self rsString:@"abcdefgh"];
    
    return YES;
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
