//
//  SwipeInteractionController.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/29/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwipeInteractionController : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interactionInProgress;

- (void)wireToViewController:(UIViewController*)viewController;

@end
