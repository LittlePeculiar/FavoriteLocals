//
//  CollectionTableCell.m
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import "CollectionTableCell.h"
#import "CollectionCell.h"
#import "LocationInfo.h"
#import <Parse/Parse.h>



@implementation CollectionTableCell

NSString * const REUSE_COLLECTION_CELLID = @"CollectionCell";

- (void)awakeFromNib
{
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.34f green:0.67f blue:0.53f alpha:1.0f];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(150.0, 170.0);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Register the custom collection cell
    UINib *collectionNib = [UINib nibWithNibName:REUSE_COLLECTION_CELLID bundle:[NSBundle bundleForClass:[CollectionCell class]]];
    [self.collectionView registerNib:collectionNib forCellWithReuseIdentifier:REUSE_COLLECTION_CELLID];
}

- (void)loadCollectionData:(NSArray *)collectionData
{
    self.collectionData = collectionData;
    [self.collectionView setContentOffset:CGPointZero animated:NO];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_COLLECTION_CELLID forIndexPath:indexPath];
    
    LocationInfo *info = [self.collectionData objectAtIndex:indexPath.row];
    
    // Configure the cell
    PFFile *thumbnail = info.imageFile;
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    cell.surfTitle.text = info.name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LocationInfo *info = [self.collectionData objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:info];
}


@end
