//
//  AppDelegate.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "WMPageController.h"
#import "NewViewController.h"
#import "BeijingViewController.h"
#import "ShanghaiViewController.h"
#import "HangzhouViewController.h"
#import "HaiwaiViewController.h"
#import "OtherViewController.h"
#import "SDWebImageManager.h"
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMSocialData setAppKey:@"5630606de0f55a8cf700061e"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSArray *viewControllers=[[NSArray alloc]initWithObjects:[NewViewController class],[BeijingViewController class],[ShanghaiViewController class],[HangzhouViewController class],[HaiwaiViewController class],[OtherViewController class],nil];
    NSArray *titles=[[NSArray alloc]initWithObjects:@"最新",@"北京",@"上海",@"杭州",@"海外",@"其他", nil];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.title = @"艺术聚焦";
    pageVC.menuItemWidth = 120;
    pageVC.titleSizeSelected = 22;
    pageVC.pageAnimatable = YES;
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pageVC];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager]cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
@end
