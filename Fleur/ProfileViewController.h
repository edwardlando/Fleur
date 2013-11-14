//
//  ProfileViewController.h
//  Fleur
//
//  Created by Ricardo Del Toro on 11/11/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UIGestureRecognizerDelegate, UIActionSheetDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>  {
    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIImageView *coverPhoto;
    IBOutlet UIImageView *profilePhoto;
    
    IBOutlet UILabel *profileName;
    IBOutlet UILabel *profileBio;
    IBOutlet UILabel *userLocation;
    IBOutlet UIImageView *locationIcon;

    IBOutlet UILabel *followers;
    IBOutlet UILabel *folliowng;
    IBOutlet UILabel *followersCount;
    IBOutlet UILabel *followingCount;
    
    IBOutlet UICollectionView *_collectionView;
    
    IBOutlet UIImageView *follow;
    IBOutlet UIImageView *following;
    
    IBOutlet UIImage *imageCover;
    IBOutlet UIImage *profileImage;
    

    int photoSource;
    
    
}


@property (nonatomic, retain) IBOutlet UIImageView *coverPhoto;
@property (nonatomic, retain) IBOutlet UIImageView *profilePhoto;


- (IBAction)back:(id)sender;
- (IBAction)edit:(id)sender;


@end
