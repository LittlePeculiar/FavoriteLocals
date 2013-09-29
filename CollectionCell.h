//
//  CollectionCell.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet PFImageView *surfImage;
@property (nonatomic, weak) IBOutlet UILabel *surfTitle;

@end
