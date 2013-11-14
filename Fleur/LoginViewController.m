//
//  LoginViewController.m
//  Fleur
//
//  Created by Reed Rosenbluth on 11/5/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"



@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize emailField;
@synthesize passwordField;
@synthesize signUpButton;
@synthesize passwordConfirm;
@synthesize loginButton;
@synthesize navBar;


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
    // Do any additional setup after loading the view from its nib.
    
    emailField.textColor = [UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1.0];
    passwordField.textColor = [UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1.0];

    navBar.tintColor = [UIColor colorWithRed:254.0/255.0 green:153/255.0 blue:73/255.0 alpha:1.0];
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [emailField becomeFirstResponder];
    
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == emailField) {
        
        [passwordField becomeFirstResponder];
        
        
    }
    
    
    if (textField == passwordField) {
        
        // log in the user
        
        [self signUpUser];
        
        
        
    }
    
    
    
    return YES;
    
    
}


- (void)signUpUser {
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"email": emailField.text,
                                  @"password": passwordField.text };
    [manager POST:@"http://www.fleurapp.com/api/v1/signup/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (responseObject[@"auth_token"]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:responseObject[@"email"] forKey:@"email"];
            [defaults setObject:responseObject[@"auth_token"] forKey:@"token"];
            [defaults synchronize];
            UIViewController* presentingViewController = self.presentingViewController;
            [self dismissViewControllerAnimated:TRUE completion:^{
                [presentingViewController dismissViewControllerAnimated:FALSE completion:nil];
            }];
        } else {
            NSArray *errorStrings = [responseObject objectForKey:@"status"];
            NSString *errorString = [errorStrings componentsJoinedByString:@"\n"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, Something went wrong" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        NSLog(@"Error: %@", error);
    }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUp:(id)sender {
    
    [self signUpUser];
    

}

- (IBAction)logIn:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"email": emailField.text,
                                  @"password": passwordField.text };
    [manager POST:@"http://www.fleurapp.com/api/v1/login/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (responseObject[@"auth_token"]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:responseObject[@"email"] forKey:@"email"];
            [defaults setObject:responseObject[@"auth_token"] forKey:@"token"];
            [defaults synchronize];
            UIViewController* presentingViewController = self.presentingViewController;
            [self dismissViewControllerAnimated:TRUE completion:^{
                [presentingViewController dismissViewControllerAnimated:FALSE completion:nil];
            }];
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
}


- (IBAction)signUpToggle:(id)sender {
    passwordConfirm.hidden = FALSE;
    loginButton.title = @"Sign Up";
    loginButton.action = @selector(signUp:);
}

- (IBAction)forgotPassword:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Open in Safari" message:@"To reset your password, Fleur will redirect you to Safari" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Open in Safari", nil];
    [alert show];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        
    }
    
    
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fleurapp.com"]];
    
         
        
    }
    
    
}




- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
@end
