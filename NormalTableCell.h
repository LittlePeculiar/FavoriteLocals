//
//  NormalTableCell.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *cellTitle;
@property (nonatomic, weak) IBOutlet PFImageView *cellImage;

@end
