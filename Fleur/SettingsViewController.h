//
//  SettingsViewController.h
//  Fleur
//
//  Created by Ricardo Del Toro on 11/11/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>  {
    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITableView *_tableView;
    
    NSArray *array;
    NSArray *legalArray;
    NSArray *logOutArray;
    
    NSMutableArray *dataArray;
    
    
}


- (IBAction)back:(id)sender;



@end
