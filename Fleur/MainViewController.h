//
//  MainViewController.h
//  Fleur
//
//  Created by Reed Rosenbluth on 11/2/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSSlidingViewController.h"


@protocol MenuButtonDelegate;



@interface MainViewController : UIViewController <UIGestureRecognizerDelegate, UIActionSheetDelegate, JSSlidingViewControllerDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UINavigationBar *nav;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) int itemIndex;
@property (nonatomic) bool firstLoad;


- (IBAction)like:(id)sender;
- (IBAction)dislike:(id)sender;
- (IBAction)shareItem:(id)sender;


- (void)updateBottomCard:(int)i;
- (void)loadItems;
- (void)loadMoreItems;
- (void)menuButtonPressed:(id)sender;
- (UIImage *)getBottomImage;


@property (nonatomic, weak) id <MenuButtonDelegate> delegate;

@end

@protocol MenuButtonDelegate <NSObject>

- (void)menuButtonPressed:(id)sender;
- (void)lockSlider;
- (void)unlockSlider;


@end