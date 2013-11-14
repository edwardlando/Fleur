//
//  AppDelegate.h
//  Fleur
//
//  Created by Reed Rosenbluth on 11/2/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "JSSlidingViewController.h"

@class SidebarViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate,MenuButtonDelegate, JSSlidingViewControllerDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JSSlidingViewController *viewController;
@property (strong, nonatomic) SidebarViewController *backVC;
@property (strong, nonatomic) MainViewController *frontVC;


- (void)lockSlider;


@end
