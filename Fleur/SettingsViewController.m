//
//  SettingsViewController.m
//  Fleur
//
//  Created by Ricardo Del Toro on 11/11/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "SettingsViewController.h"
#define kActionSheetOne 1


@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    array = [[NSArray alloc] initWithObjects:@"Username", @"Email", @"Facebook", @"Twitter", nil];
    legalArray = [[NSArray alloc] initWithObjects:@"Support", @"Privacy Policy", @"Terms of Use", nil];
    logOutArray = [[NSArray alloc] initWithObjects:@"Log Out", nil];
    
    
    dataArray = [[NSMutableArray alloc] init];
    
    NSDictionary *firstDictionary = [NSDictionary dictionaryWithObject:array forKey:@"data"];
    [dataArray addObject:firstDictionary];
    
    NSDictionary *secondDictionary = [NSDictionary dictionaryWithObject:legalArray forKey:@"data"];
    [dataArray addObject:secondDictionary];
    
    NSDictionary *thirdDictionary = [NSDictionary dictionaryWithObject:logOutArray forKey:@"data"];
    [dataArray addObject:thirdDictionary];
    
    
    
    
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
    
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myID = @"MY_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myID];
    
    if (cell == Nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myID];
        
    }
    

    [dataArray objectAtIndex:indexPath.section];

    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *sectionedArray = [dictionary objectForKey:@"data"];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    NSString *cellValue = [sectionedArray objectAtIndex:indexPath.row];

    
    cell.textLabel.text = cellValue;
    
    cell.textLabel.textColor = [UIColor colorWithRed:141.0/255.0 green:146.0/255.0 blue:155.0/255.0 alpha:1.0];
    
        
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
            
            // username
            
            
        }
        
        if (indexPath.row == 1) {
            // email
            
    
        }
    
        if (indexPath.row == 2) {
            
    
            // facebook
            
        }
        
        if (indexPath.row == 3) {
            // twitter
            
            
            
        }
        
        
        
    }

    
    if (indexPath.section == 1) {
        
        
        if (indexPath.row == 0) {
            
            //support

            MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            
            NSArray *toRecipients = [NSArray arrayWithObject: @"support@fleurapp.com"];
            [controller setToRecipients:toRecipients];
            
            [controller setSubject:@"Fleur Support"];
            [controller setMessageBody:nil isHTML:YES];
            
            
            if (controller) {
                [self presentViewController:controller animated:YES completion:nil];
            
            }
            
            
            
            
            
        }
        
        
        if (indexPath.row == 1) {
            // privacy policy
        }
        
        if (indexPath.row == 2) {
            // TOS
        }
        
        
        
    }
    
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Log Out" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Log Out" otherButtonTitles:nil];
            action.tag = kActionSheetOne;
        
            [action showInView:self.view];
            
            
        }
        
    }
    
    
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 0 ){
        
        // log out
    }
    
}



- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        

        NSLog(@"MessageSent");
        
        
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
