//
//  AppDelegate.m
//  Fleur
//
//  Created by Reed Rosenbluth on 11/2/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "SidebarViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize frontVC, backVC;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.frontVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:Nil];
    
    self.frontVC.delegate = self;
    
    UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController:self.frontVC];
    [navCont.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:251.0/255.0 blue:248.0/255.0 alpha:1.0]];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, navCont.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:254.0/255.0 green:221.0/255.0 blue:199.0/255.0 alpha:1.0];
    [navCont.view addSubview:lineView];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FleurLogo"]];
    logo.frame = CGRectMake(160 - 16, 24, logo.frame.size.width, logo.frame.size.height);
    [navCont.view addSubview:logo];

    self.backVC = [[SidebarViewController alloc] initWithNibName:@"SidebarViewController" bundle:Nil];
    self.viewController = [[JSSlidingViewController alloc] initWithFrontViewController:navCont backViewController:self.backVC];
    self.viewController.delegate = self;
    self.viewController.locked = YES;
    self.viewController.useParallaxMotionEffect = YES;
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}


- (BOOL)slidingViewController:(JSSlidingViewController *)viewController shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientationsForSlidingViewController:(JSSlidingViewController *)viewController {
    return UIInterfaceOrientationMaskAll;
}


- (void)menuButtonPressed:(id)sender {
    if (self.viewController.isOpen == NO) {
        [self.viewController openSlider:YES completion:nil];
    } else {
        [self.viewController closeSlider:YES completion:nil];
    }
}

- (void)lockSlider {
    self.viewController.locked = YES;
}

- (void)unlockSlider {
    self.viewController.locked = NO;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    self.viewController.allowManualSliding = NO;
    self.viewController.leftShadowWidth = 1.0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
