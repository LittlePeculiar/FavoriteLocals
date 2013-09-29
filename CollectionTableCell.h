//
//  CollectionTableCell.h
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *collectionData;

- (void)loadCollectionData:(NSArray *)collectionData;


@end
