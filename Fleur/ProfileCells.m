//
//  ProfileCells.m
//  Fleur
//
//  Created by Ricardo Del Toro on 11/12/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import "ProfileCells.h"

@implementation ProfileCells

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code

        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
        
        
        
        self.contentView.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;
        self.contentView.layer.borderWidth = 1;
        [self.contentView addSubview:self.imageView];
        

        
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
