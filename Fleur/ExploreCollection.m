//
//  ExploreCollection.m
//  Fleur
//
//  Created by Ricardo Del Toro on 11/12/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "ExploreCollection.h"
#import <QuartzCore/QuartzCore.h>


@implementation ExploreCollection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // work on here to fit the user image.
        
        self.userImage = [[UIImageView alloc] init];
        
        
        
        self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.usernameLabel.font = [UIFont fontWithName:@"Nexa Bold" size:13];
        
        self.usernameLabel.textColor = [UIColor colorWithRed:114.0/255.0 green:115.0/255.0 blue:121.0/255.0 alpha:1.0];
 

        self.contentView.layer.borderColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1.0].CGColor;
        
        
        self.contentView.layer.borderWidth = 1;

        self.contentView.layer.cornerRadius = 30;
        
        [self.contentView addSubview:self.usernameLabel];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
