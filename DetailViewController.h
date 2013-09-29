//
//  DetailViewController.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationInfo;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) LocationInfo *detailInfo;
@property (nonatomic, assign) NSInteger detailType;

@end
