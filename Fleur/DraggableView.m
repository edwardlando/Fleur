//
//  DraggableView.m
//  draggableView
//
//

#import "DraggableView.h"
#import "AFHTTPRequestOperationManager.h"

@interface DraggableView ()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation DraggableView

@synthesize imageView, itemLabel;

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame item:(Item*)item
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _defaults = [NSUserDefaults standardUserDefaults];
        
        _item = item;

//        self.imageView = [[UIImageView alloc] initWithImage:item.image];
//        imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 247)];
//        imageView.imageURL = item.imageUrl;
        imageView = item.imageView;
        imageView.frame = CGRectMake(0, 0, 290, 247);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        
        _likeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Like"]];
        _likeImage.frame = CGRectMake(20, 20, 80, 80);
        _likeImage.alpha = 0.0f;
        [self addSubview:_likeImage];
        
        _nopeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nope"]];
        _nopeImage.frame = CGRectMake(190, 20, 80, 80);
        _nopeImage.alpha = 0.0f;
        [self addSubview:_nopeImage];
        
        UIView *labelBG = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 50, frame.size.width, 50)];
        [labelBG setBackgroundColor:[UIColor blackColor]];
        [labelBG setAlpha:0.5];
        [self addSubview:labelBG];
        
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 48, frame.size.width - 20, 50)];
        itemLabel.text = item.itemTitle;
        itemLabel.font = [UIFont fontWithName:@"NexaLight" size:20];
        itemLabel.textAlignment = NSTextAlignmentLeft;
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textColor = [UIColor whiteColor];
        itemLabel.alpha = 1.0f;
        [self addSubview:itemLabel];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loveItem)];
        tapRecognizer.numberOfTapsRequired = 2;
        tapRecognizer.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapRecognizer];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    offset = [aTouch locationInView: self];
    
    //bring me to top 
    [self.superview bringSubviewToFront:self];
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    CGPoint temp = CGPointMake(location.x - offset.x + 140, location.y - offset.y + 125);
    
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    self.center = temp;
    [UIView commitAnimations];
    
    //swipe right
    if (self.center.x >= 160) {
        [self setTransform:CGAffineTransformMakeRotation(((self.center.x - 160.0f)/160.0f) * (M_PI/7))];
        _likeImage.alpha = (self.center.x - 160.0f)/160.0f;
        _nopeImage.alpha = 0.0f;
    }
    //swipe left
    else {
        [self setTransform:CGAffineTransformMakeRotation((self.center.x - 160.0f)/160.0f * (M_PI/7))];
        _nopeImage.alpha = (160.0f - self.center.x)/160.0f;
        _likeImage.alpha = 0.0f;
    }
    
}

-(void)loveItem {
    [UIView animateWithDuration: 0.2
                          delay: 0
                        options: (UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.center = CGPointMake(700, 190);
                     }
                     completion:^(BOOL finished) {
                         _likeImage.alpha = 0.0f;
                         _nopeImage.alpha = 0.0f;
                         NSDictionary *parameters = @{ @"user_token": [_defaults objectForKey:@"token"],
                                                       @"item_id": _item.itemId };
                         
                         _item = _parent.items[_parent.itemIndex - 1];
                         self.imageView.image = _item.imageView.image;
                         [itemLabel setText:_item.itemTitle];
                         [self setTransform:CGAffineTransformMakeRotation(0)];
                         self.center = CGPointMake(160, 213);
                         
                         [_parent updateBottomCard:_parent.itemIndex];
                         _parent.itemIndex++;
                         
                         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                         [manager POST:@"http://www.fleurapp.com/api/v1/love/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             NSLog(@"JSON: %@", responseObject);
                             
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, Something went wrong" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                             [alert show];
                             NSLog(@"Error: %@", error);
                         }];
                     }
     ];
}

- (void)swipeRight:(CGPoint)location {
    [UIView animateWithDuration: 0.2
                          delay: 0
                        options: (UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.center = CGPointMake(700, location.y);
                     }
                     completion:^(BOOL finished) {
                         _likeImage.alpha = 0.0f;
                         _nopeImage.alpha = 0.0f;
                         NSDictionary *parameters = @{ @"user_token": [_defaults objectForKey:@"token"],
                                                       @"item_id": _item.itemId };
                         
                         _item = _parent.items[_parent.itemIndex - 1];
                         self.imageView.image = _item.imageView.image;
                         [itemLabel setText:_item.itemTitle];
                         [self setTransform:CGAffineTransformMakeRotation(0)];
                         self.center = CGPointMake(160, 213);
                         
                         [_parent updateBottomCard:_parent.itemIndex];
                         _parent.itemIndex++;
                         
                         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                         [manager POST:@"http://www.fleurapp.com/api/v1/like/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             NSLog(@"JSON: %@", responseObject);
                             
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, Something went wrong" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                             [alert show];
                             NSLog(@"Error: %@", error);
                         }];
                     }
     ];
}

- (void)swipeLeft:(CGPoint)location {
    [UIView animateWithDuration: 0.2
                          delay: 0
                        options: (UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.center = CGPointMake(-380, location.y);
                     }
                     completion:^(BOOL finished) {
                         _likeImage.alpha = 0.0f;
                         _nopeImage.alpha = 0.0f;
                         NSDictionary *parameters = @{ @"user_token": [_defaults objectForKey:@"token"],
                                                       @"item_id": _item.itemId };
                         
                         _item = _parent.items[_parent.itemIndex - 1];
                         self.imageView.image = _item.imageView.image;
                         [itemLabel setText:_item.itemTitle];
                         [self setTransform:CGAffineTransformMakeRotation(0)];
                         self.center = CGPointMake(160, 213);
                         
                         [_parent updateBottomCard:_parent.itemIndex];
                         _parent.itemIndex++;
                         
                         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                         [manager POST:@"http://www.fleurapp.com/api/v1/dislike/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             NSLog(@"JSON: %@", responseObject);
                             
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, Something went wrong" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                             [alert show];
                             NSLog(@"Error: %@", error);
                         }];
                     }
     ];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    //swipe right
    if (self.center.x >= 250) {
        [self swipeRight:location];
    }
    //swipe left
    else if (self.center.x <= 70){
        [self swipeLeft:location];
    } else {
        [UIView animateWithDuration: 0.2
            delay: 0
            options: (UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
            animations:^{
                 [self setTransform:CGAffineTransformMakeRotation(0)];
            }
            completion:^(BOOL finished) { }
        ];
        self.center = CGPointMake(160, 213);
        _likeImage.alpha = 0.0f;
        _nopeImage.alpha = 0.0f;
    }
}

@end
