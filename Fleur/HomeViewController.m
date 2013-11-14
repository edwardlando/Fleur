//
//  HomeViewController.m
//  Fleur
//
//  Created by Reed Rosenbluth on 11/10/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "HomeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>




@interface HomeViewController ()



@end






@implementation HomeViewController
@synthesize fleurLabel;
@synthesize phraseLabel;
@synthesize emailButton;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [fleurLabel setFont:[UIFont fontWithName:@"NexaLight" size:48]];
    [phraseLabel setFont:[UIFont fontWithName:@"NexaLight" size:18]];

    emailButton.font = [UIFont fontWithName:@"Nexa Light" size:18];
    emailButton.textColor = [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1.0];
    
    
    UITapGestureRecognizer *tapSignInLabel;
    tapSignInLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signInButtonTapped:)];
    tapSignInLabel.delegate = self;
    tapSignInLabel.numberOfTapsRequired = 1;
    emailButton.userInteractionEnabled = YES;
    [emailButton addGestureRecognizer:tapSignInLabel];
    
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    if (netStatus == NotReachable) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Check your internet connection, Fleur could be having some issues." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}



- (void)signInButtonTapped:(UITapGestureRecognizer *)signInButtonTapped {
 
    LoginViewController *lc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:lc animated:TRUE completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInWithFacebook:(id)sender {
    NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
           allowLoginUI:YES
      completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
          
          AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
          NSDictionary *parameters = @{ @"oauth_token": [[session accessTokenData] accessToken]};
          [manager POST:@"http://www.fleurapp.com/api/v1/signup/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              if (responseObject[@"auth_token"]) {
                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                  [defaults setObject:responseObject[@"email"] forKey:@"email"];
                  [defaults setObject:responseObject[@"auth_token"] forKey:@"token"];
                  
                  NSURL *url = [NSURL URLWithString:responseObject[@"image"]];
                  NSData *data = [NSData dataWithContentsOfURL:url];
                  UIImage *profileImage = [UIImage imageWithData:data];
                  NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/profile.jpg"];
                  
                  BOOL ok = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
                  
                  if (!ok) {
                      NSLog(@"Error creating file %@", path);
                  } else {
                      NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
                      [myFileHandle writeData:UIImagePNGRepresentation(profileImage)];
                      [myFileHandle closeFile];
                  }
                  
                  [defaults setObject:path forKey:@"profileImage"];
                  [defaults synchronize];
                  [self dismissViewControllerAnimated:TRUE completion:nil];
              } else {
                  NSArray *errorStrings = [responseObject objectForKey:@"status"];
                  NSString *errorString = [errorStrings componentsJoinedByString:@"\n"];
                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                  [alert show];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, Something went wrong" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
              [alert show];
              NSLog(@"Error: %@", error);
          }];
  }];
}




@end
