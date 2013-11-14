//
//  DraggableView.h
//  draggableView
//
//  Created by coolbeet on 7/18/13.
//  Copyright (c) 2013 suyu zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "MainViewController.h"
#import "AsyncImageView.h"

@interface DraggableView : UIView {
    CGPoint offset;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *likeImage;
@property (nonatomic, strong) UIImageView * nopeImage;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) Item *item;
@property (nonatomic, weak) MainViewController *parent;

- (id)initWithFrame:(CGRect)frame item:(Item*)item;

- (void)swipeRight:(CGPoint)location;
- (void)swipeLeft:(CGPoint)location;
- (void)loveItem;

@end
