//
//  HomeViewController.h
//  Fleur
//
//  Created by Reed Rosenbluth on 11/10/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController <UIGestureRecognizerDelegate>  {
    
    
}

@property (strong, nonatomic) IBOutlet UILabel *fleurLabel;
@property (strong, nonatomic) IBOutlet UILabel *phraseLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailButton;



- (IBAction)signInWithFacebook:(id)sender;

@end
