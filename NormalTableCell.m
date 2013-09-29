//
//  NormalTableCell.m
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import "NormalTableCell.h"

@implementation NormalTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
