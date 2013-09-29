//
//  BouncePresentAnimationController.m
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/29/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import "BouncePresentAnimationController.h"

@implementation BouncePresentAnimationController

// specifies the length of the transition animation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.9;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // obtain state from the context
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    // obtain the container view
    UIView *containerView = [transitionContext containerView];
    
    //
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    toViewController.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    // add the view
    [containerView addSubview:toViewController.view];
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // set the state to animate to
                         fromViewController.view.alpha = 0.5;
                         toViewController.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         // inform the context of completion
                         fromViewController.view.alpha = 1.0;
                         [transitionContext completeTransition:YES];
                     }];
}

@end
