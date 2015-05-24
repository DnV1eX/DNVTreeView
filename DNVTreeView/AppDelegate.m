//
//  AppDelegate.m
//  DNVTreeView
//
//  Created by Alexey Demin on 20/05/15.
//  Copyright (c) 2015 Alexey Demin. All rights reserved.
//

#import "AppDelegate.h"
#import "DNVTreeViewController.h"


NSString *const TreeNodeTitleKey = @"title";
NSString *const TreeNodeChildrenKey = @"children";
NSString *const TreeNodeIsExpandedKey = @"isExpanded";


@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.treeNodes = @[
        [@{TreeNodeTitleKey: @"1", TreeNodeChildrenKey: @[
            [@{TreeNodeTitleKey: @"1.1"} mutableCopy],
            [@{TreeNodeTitleKey: @"1.2", TreeNodeChildrenKey: @[
                [@{TreeNodeTitleKey: @"1.2.1"} mutableCopy],
            ]} mutableCopy],
            [@{TreeNodeTitleKey: @"1.3"} mutableCopy],
        ]} mutableCopy],
        [@{TreeNodeTitleKey: @"2", TreeNodeChildrenKey: @[
            [@{TreeNodeTitleKey: @"2.1"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.2"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.3"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.4"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.5"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.6"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.7"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.8"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.9"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.10"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.11"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.12"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.13"} mutableCopy],
            [@{TreeNodeTitleKey: @"2.14", TreeNodeChildrenKey: @[
                [@{TreeNodeTitleKey: @"2.14.1"} mutableCopy],
            ]} mutableCopy],
        ]} mutableCopy],
        [@{TreeNodeTitleKey: @"3"} mutableCopy],
    ];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [DNVTreeViewController new];
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

@end
