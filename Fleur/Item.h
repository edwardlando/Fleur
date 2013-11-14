//
//  Item.h
//  Fleur
//
//  Created by Reed Rosenbluth on 11/6/13.
//  Copyright (c) 2013 Applause Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncImageView.h"

@interface Item : NSObject

@property (nonatomic, copy) NSURL *imageUrl;
@property (nonatomic, strong) AsyncImageView *imageView;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) NSString *itemId;

@end
