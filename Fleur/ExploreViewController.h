//
//  ExploreViewController.h
//  Fleur
//
//  Created by Ricardo Del Toro on 11/11/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreViewController : UIViewController <UICollectionViewDataSource, UICollisionBehaviorDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
    
    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UICollectionView *_collectionView;
    
    IBOutlet UILabel *suggestedUsers;
    

    
    
}

- (IBAction)back:(id)sender;



@end
