//
//  SidebarViewController.h
//  Fleur
//
//  Created by Ricardo Del Toro on 11/10/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarViewController : UIViewController <UITableViewDataSource, UIGestureRecognizerDelegate, UITableViewDelegate>  {
    
    
    NSArray *title;
    NSArray *iconArray;
    
    NSArray *discoveryTitle;
    NSArray *discoveryIcon;
    
    
    
    IBOutlet UITableView *_tableView;
   
    IBOutlet UILabel *profileName;
    IBOutlet UILabel *username;
    IBOutlet UIImageView *profileIcon;
    
    NSMutableArray *dataArray;

    
    
}



@end
