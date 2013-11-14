//
//  SidebarViewController.m
//  Fleur
//
//  Created by Ricardo Del Toro on 11/10/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "SidebarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "ExploreViewController.h"




@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadProfileDataNotification:) name:@"LoadProfileDataNotification" object:nil];

        
    }
    return self;
}


- (void)LoadProfileDataNotification:(NSNotification *)LoadProfileDataNotification {

    // start loading the profile image here and only here. This view is loaded upon start and you don't want to load this along with shots.
    // this method will only get called when the user uses the hamburger menu.
    
    NSLog(@"HamburgerMenuUsed");
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    profileIcon.userInteractionEnabled = YES;
    [profileIcon addGestureRecognizer:tap];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:[defaults objectForKey:@"profileImage"]];
    UIImage* loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    profileIcon.image = loadedImage;
    profileIcon.layer.cornerRadius = 25;
    profileIcon.layer.masksToBounds = YES;
    
    
    if ([defaults objectForKey:@"email"]) {
        profileName.text = [defaults objectForKey:@"email"];
    }
    username.text = @"@username";
    profileName.font = [UIFont fontWithName:@"Nexa Light" size:15];
    username.font = [UIFont fontWithName:@"Nexa Light" size:15];
    profileName.textColor = [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:1.0];
    username.textColor = [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:1.0];
    
    
    
    
    title = [[NSArray alloc] initWithObjects:@"Home", @"Activity", @"Profile", @"Explore", @"Leaderboards", @"Settings", nil];
    
    iconArray = [[NSArray alloc] initWithObjects:@"HomeButton.png", @"ActivityIcon.png", @"ProfileIcon.png", @"SearchButton.png", @"LeaderboardIcon.png",  @"SettingsIcon.png", nil];
    
    discoveryTitle = [[NSArray alloc] initWithObjects:@"Find Friends", @"Invite Friends", nil];
    discoveryIcon = [[NSArray alloc] initWithObjects:@"FindFriends.png", @"FindFriends.png", nil];
    

    dataArray = [[NSMutableArray alloc] init];
    
    
    NSDictionary *firstArrary = [NSDictionary dictionaryWithObject:title forKey:@"data"];
    [dataArray addObject:firstArrary];
    
    NSDictionary *secondArray = [NSDictionary dictionaryWithObject:discoveryTitle forKey:@"data"];
    [dataArray addObject:secondArray];
    
    NSDictionary *thirdArray = [NSDictionary dictionaryWithObject:iconArray forKey:@"imageData"];
    [dataArray addObject:thirdArray];
    
    NSDictionary *fourthArray = [NSDictionary dictionaryWithObject:discoveryIcon forKey:@"imageData"];
    [dataArray addObject:fourthArray];
    
    

    
}


- (void)tap:(UITapGestureRecognizer *)tap {
    NSLog(@"Tap");
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *sectionedArray = [dictionary objectForKey:@"data"];
    
    return [sectionedArray count];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        
        return @"My Account";
        
    }
    
    if (section == 1) {
        
        return @"Discovery";
        

        
    }

    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *myID = @"MY_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myID];
    
    if (cell == Nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myID];
                
    }
    
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *sectionedArray = [dictionary objectForKey:@"data"];
    NSArray *sectionedArrayImage = [dictionary objectForKey:@"imageData"];

    NSString *cellValue = [sectionedArray objectAtIndex:indexPath.row];

    UIImage *imageValue = [sectionedArrayImage objectAtIndex:indexPath.row];

    
    
    
    cell.textLabel.text = cellValue;

    cell.imageView.image = imageValue;
    
    

    
    
    cell.textLabel.textColor = [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:126.0/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"Nexa Light" size:18];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectedCell = nil;
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *selectedArray = [dictionary objectForKey:@"data"];
    selectedCell = [selectedArray objectAtIndex:indexPath.row];

    if (indexPath.section == 0) {
        
        
        if (indexPath.row == 0) {
            
            // home
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseHamburgerMenuNotification" object:nil];
            

            
        }
        
        if (indexPath.row == 1) {
            
            // activity
            
        }
    
        if (indexPath.row == 2) {
            
            // profile
            
            ProfileViewController *profile = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:Nil];
            [self presentViewController:profile animated:YES completion:Nil];
            
        }
    
        if (indexPath.row == 3) {
            // explore
            
            ExploreViewController *explore = [[ExploreViewController alloc] initWithNibName:@"ExploreViewController" bundle:nil];
            [self presentViewController:explore animated:YES completion:nil];
            
            
        }

        
        if (indexPath.row == 4) {
            // leaderboards
            
        }


        if (indexPath.row == 5) {
            // settings

            SettingsViewController *settings = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
            [self presentViewController:settings animated:YES completion:nil];
            
            
            
            

            

        
        }
        
        
        
    }
    
    
    
    if (indexPath.section == 1){
        
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
