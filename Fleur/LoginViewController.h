//
//  LoginViewController.h
//  Fleur
//
//  Created by Reed Rosenbluth on 11/5/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>  {
    
    
    
}

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UIView *passwordConfirm;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)signUp:(id)sender;
- (IBAction)logIn:(id)sender;
- (IBAction)signUpToggle:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)back:(id)sender;

@end
