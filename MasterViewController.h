//
//  MasterViewController.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DetailViewController;

@interface MasterViewController : PFQueryTableViewController

@property (strong, nonatomic) DetailViewController *tableDetailViewController;
@property (strong, nonatomic) DetailViewController *collectionDetailViewController;

@end
