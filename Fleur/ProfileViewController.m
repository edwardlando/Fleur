//
//  ProfileViewController.m
//  Fleur
//
//  Created by Ricardo Del Toro on 11/11/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ProfileCells.h"



#define kActionSheetOne 1
#define kActionSheetTwo 2


@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize profilePhoto;
@synthesize coverPhoto;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)edit:(id)sender {
    // I'll come back to this later, not important right now.
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self->_collectionView registerClass:[ProfileCells class] forCellWithReuseIdentifier:@"MY_COLLECTION"];
    
    
    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    profileName.font = [UIFont fontWithName:@"Nexa Light" size:16];
    profileName.textColor = [UIColor colorWithRed:18.0/255.0 green:18.0/255.0 blue:18.0/255.0 alpha:1.0];
    profileName.text = [defaults objectForKey:@"email"];
    
    
    profileBio.numberOfLines = 3;
    profileBio.font = [UIFont fontWithName:@"Nexa Light" size:16];
    profileBio.textColor = [UIColor colorWithRed:141.0/255.0 green:146.0/255.0 blue:155.0/255.0 alpha:1.0];
    profileBio.text = @"userBio";
    
    
    userLocation.numberOfLines = 1;
    userLocation.font = [UIFont fontWithName:@"Nexa Light" size:16];
    userLocation.textColor = [UIColor colorWithRed:141.0/255.0 green:146.0/255.0 blue:155.0/255.0 alpha:1.0];
    userLocation.text = @"userLocation";
    
    followers.numberOfLines = 1;
    followers.font = [UIFont fontWithName:@"Nexa Light" size:16];
    followers.textColor = [UIColor colorWithRed:141.0/255.0 green:146.0/255.0 blue:155.0/255.0 alpha:1.0];
    followers.text = @"Followers";
    
    folliowng.numberOfLines = 1;
    folliowng.font = [UIFont fontWithName:@"Nexa Light" size:16];
    folliowng.textColor = [UIColor colorWithRed:141.0/255.0 green:146.0/255.0 blue:155.0/255.0 alpha:1.0];
    folliowng.text = @"Following";

    followersCount.numberOfLines = 1;
    followersCount.font = [UIFont fontWithName:@"Nexa Light" size:16];
    followersCount.textColor = [UIColor colorWithRed:141.0/255.0 green:146.0/255.0 blue:155.0/255.0 alpha:1.0];
    followersCount.text = @"000";
    
    
    followingCount.numberOfLines = 1;
    followingCount.font = [UIFont fontWithName:@"Nexa Light" size:16];
    followingCount.textColor = [UIColor colorWithRed:141.0/255.0 green:146.0/255.0 blue:155.0/255.0 alpha:1.0];
    followingCount.text = @"000";

    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:[defaults objectForKey:@"profileImage"]];
    UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    profilePhoto.image = loadedImage;
    profilePhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    profilePhoto.layer.cornerRadius = 32;
    profilePhoto.layer.masksToBounds = YES;
    
    coverPhoto.layer.borderColor = [UIColor colorWithRed:183.0/255.0 green:183.0/255.0 blue:183.0/255.0 alpha:0.5].CGColor;
    coverPhoto.layer.borderWidth = 1;
    
    
    
    
    
    
//    
//    coverPhoto = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CoverPhotoDefault"]];
//
    
    UITapGestureRecognizer *tap;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    coverPhoto.userInteractionEnabled = YES;
    [coverPhoto addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tapProfilePhoto;
    tapProfilePhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfilePhoto:)];
    tapProfilePhoto.delegate = self;
    tapProfilePhoto.numberOfTapsRequired = 1;
    profilePhoto.userInteractionEnabled = YES;
    [profilePhoto addGestureRecognizer:tapProfilePhoto];
    
    
    UITapGestureRecognizer *tapFollow;
    tapFollow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFollow:)];
    tapFollow.numberOfTapsRequired = 1;
    tapFollow.delegate = self;
    follow.userInteractionEnabled = YES;
    
    [follow addGestureRecognizer:tapFollow];
    
    
    UITapGestureRecognizer *tapFollowing;
    tapFollowing = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFollowing:)];
    tapFollowing.delegate = self;
    tapFollowing.numberOfTapsRequired = 1;
    following.userInteractionEnabled = YES;
    [following addGestureRecognizer:tapFollowing];
    
    
    
}



- (void)tapFollow:(UITapGestureRecognizer *)tapFollow {

    // follow the cool hip user.
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [follow     setAlpha:1.0];
    [follow setAlpha:0.0];
    [UIView commitAnimations];

    
// dropping the alpha to nothing disables touch gesutures.
// Show an activity indicator while it conencts to the server, and then drop the opacity to show it's following the user, that is when the request has been completed.
    
    
    
}

- (void)tapFollowing:(UITapGestureRecognizer *)tapFollowing {
    
    // unfollow the boring user.
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [follow     setAlpha:0.0];
    [follow setAlpha:1.0];
    [UIView commitAnimations];

    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //// just did this for now, so it works.
    //    // tell it what to count when ready

    return 10;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileCells *profile = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_COLLECTION" forIndexPath:indexPath];
    
    
    
//    profile.imageView.image =
    
    
    return profile;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // probably a good idea to push to another view to show the itemDetail.
    
    
    
}

- (void)tapProfilePhoto:(UITapGestureRecognizer *)tapProfilePhoto {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Profile Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:Nil otherButtonTitles:@"Take a Photo", @"Chose from Library", nil];
    [action showInView:self.view];
    [action release];
    action.tag = kActionSheetTwo;
    
    
}

- (void)tap:(UITapGestureRecognizer *)tap {

    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Cover Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:Nil otherButtonTitles:@"Take a Photo", @"Chose from Library", nil];
    action.tag = kActionSheetOne;
    
    [action showInView:self.view];
    [action release];
    
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == kActionSheetOne) {
     
        if (buttonIndex == 0) {
            
            photoSource = 0;
            
            
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            

            [self presentViewController:imagePicker animated:YES completion:nil];
            
            
        }
        
        if (buttonIndex == 1) {
            
            photoSource = 0;
            
            
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            

        }
        
        
    }
    
    if (actionSheet.tag == kActionSheetTwo) {


        
        
        
        if (buttonIndex == 0) {
            photoSource = 1;
            

            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing   = YES;
            
            [self presentViewController:imagePicker animated:YES completion:nil];

        }
        
        
        if (buttonIndex == 1) {
            
            photoSource  = 1;
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            
            
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePicker animated:YES completion:nil];

        }
        
    }
    
        
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
    
    if (photoSource == 0) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [coverPhoto setAlpha:0.0];
        [coverPhoto setAlpha:1.0];
        [UIView commitAnimations];
        [coverPhoto setImage:imageCover];
        
        imageCover = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [coverPhoto setAlpha:0.0];
        [coverPhoto setAlpha:1.0];
        [UIView commitAnimations];
        
        [coverPhoto setImage:imageCover];
    
        
    
        // do your uploadig needs, Reed. :)
        // as far as storage, it's probably a good idea to save these photos on the disk and just retrieve them when the user sees their own profile
        // when they upload a new one, trash the old one and keep the new one.
        
        
    }
    
    
    

    

    if (photoSource == 1) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [profilePhoto setAlpha:0.0];
        [profilePhoto setAlpha:1.0];
        [UIView commitAnimations];
        [profilePhoto setImage:profileImage];
        
        profileImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.9];
        [profilePhoto   setAlpha:0.0];
        [profilePhoto setAlpha:1.0];
        [UIView commitAnimations];
        
        
        [profilePhoto setImage:profileImage];
        
        
        profilePhoto.layer.borderColor = [UIColor whiteColor].CGColor;
        profilePhoto.layer.borderWidth = 2;
        
        

    }

    

    
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
    
    
}

- (void)imagePickerControllerProfileView:(UIImagePickerController *)ProfileView didFinishPickingMediaWithInfo:(NSDictionary *)photo {
    
    
}



- (void)dealloc {
    [super dealloc];
 
    [profilePhoto release];
    [coverPhoto release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
