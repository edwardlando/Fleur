//
//  MainViewController.m
//  Fleur
//
//  Created by Reed Rosenbluth on 11/2/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "MainViewController.h"
#import "Item.h"
#import "DraggableView.h"
#import "AFHTTPRequestOperationManager.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AsyncImageView.h"

#import "SettingsViewController.h"


@interface MainViewController ()



@property (nonatomic, strong) DraggableView *topCard;
@property (nonatomic, strong) DraggableView *bottomCard;

@end

@implementation MainViewController

@synthesize nav;
@synthesize companyLabel;
@synthesize items;
@synthesize delegate;






- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.itemIndex = 2;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CloseHamburgerMenuNotification:) name:@"CloseHamburgerMenuNotification" object:nil];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _firstLoad = TRUE;
    
    companyLabel.font = [UIFont fontWithName:@"Nexa Light" size:18];
    companyLabel.textColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];

    companyLabel.text = @"@NikeUSA";
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    HomeViewController *hc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    if (![defaults objectForKey:@"token"]) {
        [self presentViewController:hc animated:FALSE completion:nil];
    }
    
    UIImage *background = [UIImage imageNamed:@"HamburgerMenu"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    [button addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:background forState:UIControlStateNormal];
    [button setBackgroundImage:background forState:UIControlStateSelected];
    button.frame = CGRectMake(0,0,22,11);
    
    
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 426, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
    [self.view addSubview:lineView];
    
   
    UITapGestureRecognizer *tapUsername;
    tapUsername = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUsername:)];
    tapUsername.delegate = self;
    tapUsername.numberOfTapsRequired = 1;
    companyLabel.userInteractionEnabled = YES;
    [companyLabel addGestureRecognizer:tapUsername];
    
}



- (void)CloseHamburgerMenuNotification:(NSNotification *)CloseHamburgerMenuNotification {
    [self.delegate menuButtonPressed:CloseHamburgerMenuNotification];
    
}



- (void)tapUsername:(UITapGestureRecognizer *)tapUsername {
    
    NSString *usernameLabel = companyLabel.text;
    
    NSString *followString = [[NSString alloc] initWithFormat:@"Follow %@", usernameLabel];

    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:followString delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Follow", @"See Profile", nil];

    [action showInView:self.parentViewController.view];
    
    
    
}


- (void)menuButtonPressed:(id)sender {
    
    [self.delegate menuButtonPressed:sender];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadProfileDataNotification" object:Nil];    
    
}



- (void)updateBottomCard:(int)i {
    _bottomCard.item = items[i];
    _bottomCard.imageView.image = _bottomCard.item.imageView.image;
    [_bottomCard.itemLabel setText:_bottomCard.item.itemTitle];
    
    if (!_firstLoad && _itemIndex == 14) {
        [self loadMoreItems];
        _firstLoad = FALSE;
    } else if (_itemIndex == 10) {
        [self loadMoreItems];
    }
}

- (UIImage *)getBottomImage {
    return _bottomCard.imageView.image;
}


- (IBAction)shareItem:(id)sender {

    // put the link in an NSString
    
    
    NSString *urlToShare = @"";
    
    NSArray *dataToShare = @[urlToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:Nil];
    [self presentViewController:activityVC animated:YES completion:Nil];

}


-(void)loadItems {
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    CGRect frame = CGRectMake(160-145, 90, 290, 247);
    items = [[NSMutableArray alloc] initWithCapacity:30];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"user_token": [defaults objectForKey:@"token"] };
    [manager GET:@"http://www.fleurapp.com/api/v1/feed_items/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *itemData in responseObject) {
            NSURL *imageURL = [NSURL URLWithString:itemData[@"image"]];
            AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:frame];
            imageView.imageURL = imageURL;
            
//            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//            UIImage *image = [UIImage imageWithData:imageData];
            
            Item *item = [[Item alloc] init];
//            [item setImageUrl:imageURL];
            [item setImageView:imageView];
            [item setItemTitle:itemData[@"name"]];
            [item setItemId:itemData[@"id"]];
        
            [items addObject:item];
        
            UIApplication *app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = NO;

        
        }
        
        _topCard = [[DraggableView alloc] initWithFrame:frame item:items[0]];
        [_topCard setParent:self];
        _bottomCard = [[DraggableView alloc] initWithFrame:frame item:items[1]];
        [_bottomCard setParent:self];
        
        
        
        [self.view addSubview:_bottomCard];
        [self.view addSubview:_topCard];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, Something went wrong" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        NSLog(@"Error: %@", error);
   
        UIApplication *app = [UIApplication sharedApplication];
        
        app.networkActivityIndicatorVisible = NO;
        
    
    
    }];
}


-(void)loadMoreItems {
    
    _itemIndex = 0;
    Item *i0 = items[10];
    Item *i1 = items[11];
    Item *i2 = items[12];
    Item *i3 = items[13];
    Item *i4 = items[14];
    
    [items removeAllObjects];
    
    [items addObject:i0];
    [items addObject:i1];
    [items addObject:i2];
    [items addObject:i3];
    [items addObject:i4];
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    CGRect frame = CGRectMake(160-145, 90, 290, 247);
    items = [[NSMutableArray alloc] initWithCapacity:30];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"user_token": [defaults objectForKey:@"token"] };
    [manager GET:@"http://www.fleurapp.com/api/v1/feed_items/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *itemData in responseObject) {
            NSURL *imageURL = [NSURL URLWithString:itemData[@"image"]];
            AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:frame];
            imageView.imageURL = imageURL;
            
            Item *item = [[Item alloc] init];
            [item setImageView:imageView];
            [item setItemTitle:itemData[@"name"]];
            [item setItemId:itemData[@"id"]];
            
            [items addObject:item];
            
            UIApplication *app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = NO;
            
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, Something went wrong" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        NSLog(@"Error: %@", error);
        
        UIApplication *app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = NO;
        
        
        
    }];
}
 





-(void)viewDidAppear:(BOOL)animated {
    
    [self loadItems];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)like:(id)sender {
    if ([self.view subviews]) {
        for (UIView *v in [[self.view subviews] reverseObjectEnumerator]) {
            if ([v isKindOfClass:[DraggableView class]]) {
                [(DraggableView *)v swipeRight:CGPointMake(160, 213)];
                break;
            }
        }
    }
}

- (IBAction)dislike:(id)sender {
    if ([self.view subviews]) {
        for (UIView *v in [[self.view subviews] reverseObjectEnumerator]) {
            if ([v isKindOfClass:[DraggableView class]]) {
                [(DraggableView *)v swipeLeft:CGPointMake(160, 213)];
                break;
            }
        }
    }
}
@end
