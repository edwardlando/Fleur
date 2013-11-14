//
//  ExploreViewController.m
//  Fleur
//
//  Created by Ricardo Del Toro on 11/11/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "ExploreViewController.h"
#import "ExploreCollection.h"


@interface ExploreViewController ()

@end

@implementation ExploreViewController




- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


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

    [self->_collectionView registerClass:[ExploreCollection class] forCellWithReuseIdentifier:@"MY_COLLECTION"];
    
    
    suggestedUsers.font = [UIFont fontWithName:@"Nexa Bold" size:14];
    suggestedUsers.text = @"Suggested Users";
    suggestedUsers.textColor = [UIColor colorWithRed:114.0/255.0 green:115.0/255.0 blue:121.0/255.0 alpha:1.0];
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
//    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ExploreCollection *explore = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_COLLECTION" forIndexPath:indexPath];
    
    

    explore.usernameLabel.text = @"@test";
    
    
    return explore;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
