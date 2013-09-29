//
//  FlipAnimationController.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/29/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlipAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL reverse;

@end
