//
//  AppDelegate.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 07/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <AFNetworking/AFNetworking.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self startNetworkMonitoring];
    [self performMigrationIfNeeded];
    [GIDSignIn sharedInstance].clientID = @"34955841339-gs8uua3eur37aoodgk3jjdc5jsv77e3v.apps.googleusercontent.com";
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self navigateToAppropriateScreen];
    return YES;
}
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
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

-(void)navigateToAppropriateScreen {
    if ([self ifAlreadyLoggedIn]) {
        [self goToHomeScreen];
    }
    else
    {
        [self goToLoginScreen];
    }
}

-(BOOL)ifAlreadyLoggedIn {
    BOOL isLoggedIn = [[[NSUserDefaults standardUserDefaults] valueForKey:isUserLoggedIn] boolValue];
    return isLoggedIn;
}

-(void)goToLoginScreen {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *login = [sb instantiateViewControllerWithIdentifier:@"Login"];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:login];
    [navigation setNavigationBarHidden:YES];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
    
}

-(void)goToHomeScreen {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HomeMaster" bundle:nil];
    UIViewController *homeMaster = [sb instantiateViewControllerWithIdentifier:@"homeMaster"];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeMaster];
    [navigation setNavigationBarHidden:YES];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
}

-(void)logout {
    [[SharedClass sharedInstance] logoutUser];
    [self goToLoginScreen];
}
-(void)performMigrationIfNeeded {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // Set the new schema version. This must be greater than the previously used
    // version (if you've never set a schema version before, the version is 0).
    config.schemaVersion = config.schemaVersion + 1;
    
    // Set the block which will be called automatically when opening a Realm with a
    // schema version lower than the one set above
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
    };
    
    // Tell Realm to use this new configuration object for the default Realm
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

-(void)startNetworkMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        
        // Check the reachability status and show an alert if the internet connection is not available
        switch (status) {
            case -1:
                // AFNetworkReachabilityStatusUnknown = -1,
                NSLog(@"The reachability status is Unknown");
                break;
            case 0:
                // AFNetworkReachabilityStatusNotReachable = 0
                NSLog(@"The reachability status is not reachable");
                break;
            case 1:
                NSLog(@"The reachability status is reachable via wan");
                break;
            case 2:
                // AFNetworkReachabilityStatusReachableViaWiFi = 2
                NSLog(@"The reachability status is reachable via WiFi");
                break;
                
            default:
                break;
        }
        
    }];
}

@end
