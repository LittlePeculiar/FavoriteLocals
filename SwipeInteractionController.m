//
//  SwipeInteractionController.m
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/29/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import "SwipeInteractionController.h"

@implementation SwipeInteractionController
{
    BOOL _shouldCompleteTransition;
    UINavigationController *_navigationController;
}

- (void)wireToViewController:(UIViewController *)viewController
{
    _navigationController = viewController.navigationController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed
{
    return  1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            // Start an interactive transition!
            self.interactionInProgress = YES;
            [_navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 2. compute the current position
            CGFloat fraction = - (translation.x / 200.0);
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            
            // 3. should we complete?
            _shouldCompleteTransition = (fraction > 0.5);
            
            // 4. update the animation
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            // 5. finish or cancel
            self.interactionInProgress = NO;
            if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }
            else {
                [self finishInteractiveTransition];
            }
            break;
            
        default:
            break;
    }
    
}

@end
